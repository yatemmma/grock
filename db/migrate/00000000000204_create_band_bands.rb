class CreateBandBands < ActiveRecord::Migration[5.2]
  def change
    create_table :band_bands, id: false do |t|
      t.string   :self_code
      t.string   :other_code
      t.string   :type
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :band_bands, [:self_code, :other_code, :type], name: "band_bands_index"
  end
end
