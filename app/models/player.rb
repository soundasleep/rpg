class Player < ApplicationRecord
  belongs_to :chunk

  validates :title, :level, :health, :mana, presence: true
end
