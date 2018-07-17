class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites, id: false do |t|
      t.string   :code, null: false
      t.string   :name
      t.string   :description
      t.string   :youtube_keys
      t.text     :body
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :sites, :code, unique: true
  end
end
