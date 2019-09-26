class AddWorldSpawnToWorld < ActiveRecord::Migration[5.2]
  def change
    add_column :worlds, :spawn_x, :integer, null: false, default: 0
    add_column :worlds, :spawn_y, :integer, null: false, default: 0
  end
end
