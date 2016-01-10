Sequel.migration do
  up do
    create_table(:posts) do
      String :id,    :primary_key=>true
      String :title, :null=>false
      String :date,  :null=>false
      String :bands
      String :type
    end
  end

  down do
    drop_table(:posts)
  end
end
