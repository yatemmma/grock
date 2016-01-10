class Video
  def self.cols
    %w(id url type band title date)
  end
  
  def self.all
    items = DB[:videos]
    items.all
  end
  
  def self.add(params)
    items = DB[:videos]
    items.insert({
      :id => params[:id],
      :url => params[:url],
      :type => params[:type],
      :band => params[:band],
      :title => params[:title],
      :date => params[:date]
    })
  end
  
  def self.get(id)
    Label.new(id).first
  end
  
  def initialize(id)
    items = DB[:videos]
    @item = items.where(:id => id)
  end
  
  def update(params)
    @item.update({
      :url => params[:url],
      :type => params[:type],
      :band => params[:band],
      :title => params[:title],
      :date => params[:date]
    })
  end
  
  def delete
    @item.delete
  end
end
