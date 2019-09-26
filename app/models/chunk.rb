class Chunk < ApplicationRecord
  belongs_to :world

  has_many :chunks, dependent: :destroy
  has_many :players, dependent: :nullify

  validates :world, :world_x, :world_y, presence: true

  validate :validate_tiles_dimensions
  validate :validate_impassable_dimensions

  def tile_width
    64
  end

  def tile_height
    64
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

  def randomize!
    tiles = Array.new(tile_height) do
      Array.new(tile_width) do
        rand(8).floor # 0..7
      end
    end

    impassable = Array.new(tile_height) do
      Array.new(tile_width) do
        rand() < 0.1 ? 1 : 0
      end
    end

    assign_tiles(tiles)
    assign_impassable(impassable)
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

    if arrays.length != tile_height
      errors.add(:key, "height of #{arrays.length} did not match expected #{tile_height}")
    end

    if arrays.first.length != tile_width
      errors.add(:key, "width of #{arrays.length} did not match expected #{tile_width}")
    end
  end
end
