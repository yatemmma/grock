Sequel.migration do
  up do
    create_table(:videos) do
      String :id,   :primary_key=>true
      String :ukey, :unique=>true
      String :url,  :null=>false
      String :type, :null=>false
      String :band, :null=>false
      String :title
      String :date
      String :recommend
    end
  end

  down do
    drop_table(:videos)
  end
end
