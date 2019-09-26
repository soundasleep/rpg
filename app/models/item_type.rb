class ItemType < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :title, :rarity, presence: true
end
