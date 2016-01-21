class CreateDiscs < ActiveRecord::Migration
  def change
    create_table :discs do |t|
      t.string :key, :unique => true
      t.string :values
    end
  end
end
