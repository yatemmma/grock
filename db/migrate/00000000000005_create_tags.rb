class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags, id: false do |t|
      t.string   :code
      t.string   :name
      t.string   :tag_type
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :tags, :code, unique: true
  end
end
