Sequel.migration do
  up do
    create_table(:labels) do
      String :id,   :primary_key=>true
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
