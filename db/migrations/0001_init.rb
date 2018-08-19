Sequel.migration do
  change do
    create_table :sites do
      primary_key :id
      String :code, unique: true, null: false
      String :name, null: false
    end
  end
end
