Sequel.migration do
  up do
    create_table(:labels) do
      primary_key :id
      String :slug, :unique=>true
      String :name, :null=>false
      String :nick, :null=>false
      String :site
      String :youtube
    end
  end

  down do
    drop_table(:labels)
  end
end
