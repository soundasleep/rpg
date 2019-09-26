class CreateItemTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_types do |t|
      t.string :title,  null: false
      t.string :rarity, null: false, default: 'common'

      t.integer :durability, null: true # not all items have durability

      t.timestamps
    end
  end
end
