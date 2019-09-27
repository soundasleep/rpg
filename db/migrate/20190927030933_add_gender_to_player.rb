class AddGenderToPlayer < ActiveRecord::Migration[5.2]
  def change
    add_column :players, :gender, :string, null: false, default: 'f'
  end
end
