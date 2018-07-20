class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags, id: false do |t|
      t.string   :kind, null: false
      t.string   :code, null: false
      t.string   :key
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :tags, [:kind, :code], name: "tags_index"
  end
end
