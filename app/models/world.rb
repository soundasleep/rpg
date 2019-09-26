class World < ApplicationRecord
  has_many :chunks, dependent: :destroy

  validates :title, :spawn_x, :spawn_y, presence: true

  def chunks_wide
    chunks.pluck(:world_x).max || 0
  end

  def chunks_high
    chunks.pluck(:world_y).max || 0
  end

  def chunk(x, y)
    @chunk ||= Hash.new do |hash, (x, y)|
      hash[[x, y]] = chunks.where(world_x: x, world_y: y).first
    end
    @chunk[[x, y]]
  end

  def tile_range
    (0..9)
  end

  def chunk_width
    64
  end

  def chunk_height
    64
  end

  # Returns { chunk, chunk_x, chunk_y } for a given world (x, y)
  def find_chunk(x, y)
    return {
      chunk:   chunks.where(world_x: x / chunk_width, world_y: y / chunk_height).first,
      chunk_x: x % chunk_width,
      chunk_y: y % chunk_height,
    }
  end

  private
end
