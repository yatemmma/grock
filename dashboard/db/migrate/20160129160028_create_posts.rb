class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :key, :unique => true
      t.string :values
    end
  end
end
