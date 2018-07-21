class CreateDiscBands < ActiveRecord::Migration[5.2]
  def change
    create_table :disc_bands do |t|
      t.string   :disc_code
      t.string   :band_code
      t.string   :type
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :disc_bands, [:disc_code, :band_code, :type], name: "disc_bands_index"
  end
end
