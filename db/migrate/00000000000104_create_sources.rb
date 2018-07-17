class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string   :kind
      t.string   :code
      t.string   :url
      t.string   :type
      t.text     :source
      t.boolean  :parsed, default: false
      t.text     :error
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :sources, [:kind, :code, :parsed], name: "sources_index"
  end
end
