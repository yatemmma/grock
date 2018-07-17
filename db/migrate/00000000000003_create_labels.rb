class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels, id: false do |t|
      t.string   :code, null: false
      t.string   :name
      t.string   :description
      t.string   :founded
      t.string   :origin
      t.string   :youtube_keys
      t.text     :body
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :labels, :code, unique: true
  end
end
