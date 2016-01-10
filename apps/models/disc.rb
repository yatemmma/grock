class Disc
  def self.cols
    %w(id title bands date label image amazon itunes stream teaser)
  end
  
  def self.all
    items = DB[:discs]
    items.all
  end
  
  def self.add(params)
    items = DB[:discs]
    items.insert({
      :id => params[:id],
      :title => params[:title],
      :bands => params[:bands],
      :date => params[:date],
      :label => params[:label],
      :image => params[:image],
      :amazon => params[:amazon],
      :itunes => params[:itunes],
      :stream => params[:stream],
      :teaser => params[:teaser]
    })
  end
  
  def self.get(id)
    Label.new(id).first
  end
  
  def initialize(id)
    items = DB[:discs]
    @item = items.where(:id => id)
  end
  
  def update(params)
    @item.update({
      :title => params[:title],
      :bands => params[:bands],
      :date => params[:date],
      :label => params[:label],
      :image => params[:image],
      :amazon => params[:amazon],
      :itunes => params[:itunes],
      :stream => params[:stream],
      :teaser => params[:teaser]
    })
  end
  
  def delete
    @item.delete
  end
end
