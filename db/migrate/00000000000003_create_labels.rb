class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels, id: false do |t|
      t.string   :code, null: false
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :labels, :code, unique: true
  end
end
