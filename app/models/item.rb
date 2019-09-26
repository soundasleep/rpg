class Item < ApplicationRecord
  belongs_to :item_type

  validates :item_type, presence: true
end
