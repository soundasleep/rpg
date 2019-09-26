class Chunk < ApplicationRecord
  belongs_to :world

  has_many :chunks, dependent: :destroy
  has_many :players, dependent: :nullify
  has_many :entities, dependent: :destroy

  validates :world, :world_x, :world_y, presence: true

  validate :validate_tiles_dimensions
  validate :validate_impassable_dimensions

  def chunk_width
    world.chunk_width
  end

  def chunk_height
    world.chunk_height
  end

  def tiles
    @tiles ||= unserialize(tiles_serialized || "")
  end

  def impassable
    @impassable ||= unserialize(impassable_serialized || "")
  end

  def assign_tiles(tiles)
    assign_attributes(tiles_serialized: serialize(tiles))
    @tiles = tiles
  end

  def assign_impassable(impassable)
    assign_attributes(impassable_serialized: serialize(impassable))
    @impassable = impassable
  end

  PATH_SE = 0
  PATH_S = 1
  PATH_SW = 2
  PATH_E = 3
  PATH_CLEAR = 4
  PATH_W = 5
  PATH_NE = 6
  PATH_N = 7
  PATH_NW = 8
  GRASS_CLEAR = 9

  def randomize!
    # Custom randomise: everything is grass, except for
    # certain blocks, which become path
    is_path = Array.new(chunk_height) do
      Array.new(chunk_width) do
        false
      end
    end

    chunk_width.times do
      width = (rand() * 6) + 1
      height = (rand() * 6) + 1
      x = (rand() * (chunk_width - width)).floor
      y = (rand() * (chunk_height - height)).floor

      (0...width).each do |dx|
        (0...height).each do |dy|
          is_path[y + dy][x + dx] = true
        end
      end
    end

    # convert into tiles

    tiles = Array.new(chunk_height) do |y|
      Array.new(chunk_width) do |x|
        path_nw = y > 0 && x > 0 && is_path[y - 1][x - 1]
        path_n = y > 0 && is_path[y - 1][x]
        path_ne = y > 0 && x < chunk_width - 1 && is_path[y - 1][x + 1]
        path_w = x > 0 && is_path[y][x - 1]
        path_e = x < chunk_width - 1 && is_path[y][x + 1]
        path_sw = y < chunk_height - 1 && x > 0 && is_path[y + 1][x - 1]
        path_s = y < chunk_height - 1 && is_path[y + 1][x]
        path_se = y < chunk_height - 1 && x < chunk_width - 1 && is_path[y + 1][x + 1]
        path = is_path[y][x]

        if path
          if !path_n
            if !path_w
              PATH_SE
            elsif !path_e
              PATH_SW
            else
              PATH_S
            end
          elsif !path_s
            if !path_w
              PATH_NE
            elsif !path_e
              PATH_NW
            else
              PATH_N
            end
          elsif !path_w
            PATH_E
          elsif !path_e
            PATH_W
          else
            # missing: path nse, nsw, nwe, swe
            PATH_CLEAR
          end
        else
          GRASS_CLEAR
        end

#        world.tile_range.min + (rand() * world.tile_range.size).floor
      end
    end

    impassable = Array.new(chunk_height) do
      Array.new(chunk_width) do
        # rand() < 0.1 ? 1 : 0
        0
      end
    end

    my_entities = Array.new((chunk_width * 0.5) + (rand() * chunk_width * 0.5)) do
      x = (rand() * (chunk_width - 4)).floor
      y = (rand() * (chunk_height - 5)).floor
      width = 4
      height = 5

      (0...width).each do |dx|
        (0...height).each do |dy|
          impassable[(y + dy).floor][(x + dx).floor] = 1
        end
      end

      entities.new({
        chunk_x: x,
        chunk_y: y,
        width: width,
        height: height,
        entity_type: "tree#{(rand() * 2).floor}",
      })
    end

    assign_tiles(tiles)
    assign_impassable(impassable)
    assign_attributes(entities: my_entities)
  end

  def to_public_json
    {
      id: id,
      world: {
        id: world.id,
        x: world_x,
        y: world_y,
      },
      tiles: tiles,
      impassable: impassable,
      players: players.map(&:to_public_json),
      entities: entities.map(&:to_public_json),
    }
  end

  private

  def serialize(arrays)
    arrays.map do |row|
      row.join(",")
    end.join("|")
  end

  def unserialize(string)
    (string || "").split("|").map do |s|
      s.split(",").map(&:to_i)
    end
  end

  def validate_tiles_dimensions
    validate_dimensions(tiles, :tiles)
  end

  def validate_impassable_dimensions
    validate_dimensions(impassable, :impassable)
  end

  def validate_dimensions(arrays, key)
    return if arrays.empty?

    if arrays.length != chunk_height
      errors.add(:key, "height of #{arrays.length} did not match expected #{chunk_height}")
    end

    if arrays.first.length != chunk_width
      errors.add(:key, "width of #{arrays.length} did not match expected #{chunk_width}")
    end
  end
end
