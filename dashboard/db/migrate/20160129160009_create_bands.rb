class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :key, :unique => true
      t.string :values
    end
  end
end
