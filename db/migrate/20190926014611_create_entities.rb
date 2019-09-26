class CreateEntities < ActiveRecord::Migration[5.2]
  def change
    # Entities are fixed objects in the world
    # which may appear and disappear at any time
    create_table :entities do |t|
      t.integer :chunk_id, null: false
      t.float   :chunk_x,  null: false # not int, because they may appear anywhere
      t.float   :chunk_y,  null: false
      t.integer :width,    null: false
      t.integer :height,   null: false

      t.string  :entity_type, null: false # 'tree', 'chest', etc. the entity type defines if it can be interacted with, impassable, etc

      t.timestamps
    end

    add_index :entities, :chunk_id
    add_index :entities, :entity_type
  end
end
