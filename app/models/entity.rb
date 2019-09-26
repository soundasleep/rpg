class Entity < ApplicationRecord
  belongs_to :chunk

  validates :chunk, :chunk_x, :chunk_y, :width, :height, :entity_type, presence: true

  def to_public_json
    {
      id: id,
      chunk: {
        id: chunk.id,
        x: chunk_x.round(2),
        y: chunk_y.round(2),
      },
      width: width,
      height: height,
      entity_type: entity_type,
    }
  end
end
