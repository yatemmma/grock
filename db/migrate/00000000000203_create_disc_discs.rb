class CreateDiscDiscs < ActiveRecord::Migration[5.2]
  def change
    create_table :disc_discs do |t|
      t.string   :self_code
      t.string   :other_code
      t.string   :type
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :disc_discs, [:self_code, :other_code, :type], name: "disc_discs_index"
  end
end
