class Entity < ApplicationRecord
  belongs_to :chunk

  validates :chunk, :chunk_x, :chunk_y, :width, :height, :entity_type, presence: true
end
