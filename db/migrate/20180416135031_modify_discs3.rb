class ModifyDiscs3 < ActiveRecord::Migration[5.2]
  def change
    add_column :discs, :original_videos, :string
    add_column :discs, :original_bands, :string
    add_column :discs, :original_discs, :string
  end
end
