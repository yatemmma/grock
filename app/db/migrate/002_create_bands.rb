Sequel.migration do
  up do
    create_table(:bands) do
      String :id,   :primary_key=>true
      String :ukey, :unique=>true
      String :name, :null=>false
      String :nick, :null=>false
      String :site
      String :wiki
      String :facebook
      String :twitter
      String :youtube
      String :soundcloud
      String :myspace
      String :purevolume
      String :lastfm
      String :instagram
      String :tumblr
      String :recommend
    end
  end

  down do
    drop_table(:bands)
  end
end
