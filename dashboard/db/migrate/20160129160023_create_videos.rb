class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :key, :unique => true
      t.string :values
    end
  end
end
