class ModifyDiscs < ActiveRecord::Migration[5.2]
  def change
    add_column :discs, :disc_type, :string
  end
end
