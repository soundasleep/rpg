class World < ApplicationRecord
  has_many :chunks, dependent: :destroy

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

  validates :title, presence: true
end
