class CreateItems < ActiveRecord::Migration[5.2]
  def change
    # instances of a specific item type
    create_table :items do |t|
      t.integer :item_type_id, null: false

      t.integer :player_id,  null: true # may be owned by a player
      t.integer :entity_id,  null: true # may be owned by an entity

      t.integer :durability, null: true # not all items have durability

      t.timestamps
    end

    add_index :items, :item_type_id
    add_index :items, :player_id
    add_index :items, :entity_id
  end
end
