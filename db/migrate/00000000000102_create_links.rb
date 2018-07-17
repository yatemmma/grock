class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links, id: false do |t|
      t.string   :kind, null: false
      t.string   :code, null: false
      t.string   :link_type
      t.string   :label
      t.string   :url
      t.string   :title
      t.boolean  :stream, default: false
      t.boolean  :purchase, default: false
      t.boolean  :feed, default: false
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :links, [:kind, :code], name: "links_index"
  end
end
