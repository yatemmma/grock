Sequel.migration do
  up do
    create_table(:posts) do
      String :id,    :primary_key=>true
      String :ukey,  :unique=>true
      String :title, :null=>false
      String :date,  :null=>false
      String :bands
      String :type
      String :media
      String :recommend
      String :body
    end
  end

  down do
    drop_table(:posts)
  end
end
