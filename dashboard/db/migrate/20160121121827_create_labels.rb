class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :key, :unique => true
      t.string :values
    end
  end
end
