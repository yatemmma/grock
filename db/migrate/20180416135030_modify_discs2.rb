class ModifyDiscs2 < ActiveRecord::Migration[5.2]
  def change
    add_column :discs, :description, :string
    add_column :discs, :wikipedia, :string
  end
end
