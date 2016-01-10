class Band
  def self.cols
    %w(id name nick site wiki facebook twitter youtube soundcloud myspace purevolume lastfm instagram tumblr)
  end
  
  def self.all
    items = DB[:bands]
    items.all
  end
  
  def self.add(params)
    items = DB[:bands]
    items.insert({
      :id => params[:id],
      :name => params[:name],
      :nick => params[:nick],
      :site => params[:site],
      :wiki => params[:wiki],
      :facebook => params[:facebook],
      :twitter => params[:twitter],
      :youtube => params[:youtube],
      :soundcloud => params[:soundcloud],
      :myspace => params[:myspace],
      :purevolume => params[:purevolume],
      :lastfm => params[:lastfm],
      :instagram => params[:instagram],
      :tumblr => params[:tumblr]
    })
  end
  
  def self.get(id)
    Band.new(id).first
  end
  
  def initialize(id)
    items = DB[:labels]
    @item = items.where(:id => id)
  end
  
  def update(params)
    @item.update({
      :name => params[:name],
      :nick => params[:nick],
      :site => params[:site],
      :wiki => params[:wiki],
      :facebook => params[:facebook],
      :twitter => params[:twitter],
      :youtube => params[:youtube],
      :soundcloud => params[:soundcloud],
      :myspace => params[:myspace],
      :purevolume => params[:purevolume],
      :lastfm => params[:lastfm],
      :instagram => params[:instagram],
      :tumblr => params[:tumblr]
    })
  end
  
  def delete
    @item.delete
  end
end
