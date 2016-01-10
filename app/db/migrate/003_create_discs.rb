Sequel.migration do
  up do
    create_table(:discs) do
      String :id,   :primary_key=>true
      String :title, :null=>false
      String :bands, :null=>false
      String :date
      String :label
      String :image
      String :amazon
      String :itunes
      String :stream
      String :teaser
    end
  end

  down do
    drop_table(:discs)
  end
end
