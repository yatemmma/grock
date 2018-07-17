class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images, id: false do |t|
      t.string   :kind, null: false
      t.string   :code, null: false
      t.string   :icon_url
      t.string   :icon_path
      t.string   :thumbnail_url
      t.string   :thumbnail_path
      t.string   :large_url
      t.string   :large_path
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :images, [:kind, :code], name: "images_index"
  end
end
