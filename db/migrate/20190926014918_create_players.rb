class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      # to come later: authorisation etc etc

      t.string :title,     null: false
      t.integer :chunk_id, null: true # null if they haven't joined a world yet. the world will decide which chunk/x/y to spawn in
      t.float :chunk_x,    null: true
      t.float :chunk_y,    null: true

      t.integer :level,    null: false, default: 1
      t.integer :health,   null: false, default: 1
      t.integer :mana,     null: false, default: 1

      t.timestamps
    end

    add_index :players, :chunk_id
  end
end
