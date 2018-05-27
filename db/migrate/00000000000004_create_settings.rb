class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings, id: false do |t|
        t.string   :code, null: false
        t.text     :json
    end
    add_index :settings, :code, unique: true
  end
end
