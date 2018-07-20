class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string   :kind, null: false
      t.string   :code, null: false
      t.string   :type
      t.string   :url
      t.text     :source
      t.text     :error
      t.boolean  :parsed, default: false
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :sources, [:kind, :code], name: "sources_index"
  end
end
