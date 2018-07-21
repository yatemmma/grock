class CreateDiscLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :disc_labels do |t|
      t.string   :disc_code
      t.string   :label_code
      t.string   :type
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :disc_labels, [:disc_code, :label_code, :type], name: "disc_labels_index"
  end
end
