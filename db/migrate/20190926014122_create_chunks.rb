class CreateChunks < ActiveRecord::Migration[5.2]
  def change
    create_table :chunks do |t|
      t.integer :world_id, null: false
      t.integer :world_x,  null: false
      t.integer :world_y,  null: false

      # Tiles are the background for the world.
      # Having 100x100 tile objects per chunk would be a lot of overhead and unnecessary.
      # We can smoosh them together into a int[][] array
      t.string :tiles_serialized, null: true # null if the tiles haven't been spawned yet

      # Identify which tiles cannot be walked on (a simple boolean[][])
      t.string :impassable_serialized, null: true # null if the tiles haven't been spawned yet

      t.timestamps
    end

    add_index :chunks, [:world_id, :world_x, :world_y]
  end
end
