class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels, id: false do |t|
        t.string :code, null: false
        t.string :name
        t.string :origin
        t.string :images
        t.string :videos
        t.string :website
        t.string :wikipedia
        t.string :youtube
        t.string :twitter
        t.string :facebook
        t.string :links
        t.text   :body
        t.boolean  :public
        t.datetime :created_at
        t.datetime :updated_at
    end
    add_index :labels, :code, unique: true
  end
end
