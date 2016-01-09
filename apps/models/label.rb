class Label
  def self.cols
    %w(id name nick site youtube)
  end
  
  def self.all
    items = DB[:labels]
    items.all
  end
  
  def self.add(params)
    items = DB[:labels]
    items.insert({
      :id => params[:id],
      :name => params[:name],
      :nick => params[:nick],
      :site => params[:site],
      :youtube => params[:youtube]
    })
  end
  
  def self.get(id)
    Label.new(id).first
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
      :youtube => params[:youtube]
    })
  end
  
  def delete
    @item.delete
  end
end
