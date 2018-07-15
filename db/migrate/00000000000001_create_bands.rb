class CreateBands < ActiveRecord::Migration[5.2]
  def change
    create_table :bands, id: false do |t|
      t.string   :code, null: false
      t.string   :name
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :bands, :code, unique: true
  end
end
