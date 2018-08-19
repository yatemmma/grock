class AddColumnToFeeds < ActiveRecord::Migration[5.2]
  def change
    add_column :feeds, :categories, :string
  end
end
