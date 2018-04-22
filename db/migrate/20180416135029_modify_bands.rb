class ModifyBands < ActiveRecord::Migration[5.2]
  def change
    add_column :bands, :amazon, :string
  end
end
