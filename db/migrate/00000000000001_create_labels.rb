class CreateLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :labels, id: false do |t|
        t.string :code, null: false
        t.string :name
        t.string :founded
        t.string :origin
        t.string :images
        t.string :videos
        t.string :website
        t.string :wikipedia
        t.string :youtube
        t.string :twitter
        t.string :facebook
        t.string :links
        t.string :feeds
        t.text   :body
        t.datetime :created_at
        t.datetime :updated_at
    end
    add_index :labels, :code, unique: true
  end
end
