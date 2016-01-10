Sequel.migration do
  up do
    create_table(:videos) do
      String :id,   :primary_key=>true
      String :url,  :null=>false
      String :type, :null=>false
      String :band
      String :title
      String :date
    end
  end

  down do
    drop_table(:videos)
  end
end
