class CommonModel
  def self.cols(name)
    case name
    when 'posts'
      %w(id url title date bands type body)
    when 'discs'
      %w(id title bands date label image amazon itunes stream teaser)
    when 'videos'
      %w(id url type band title date)
    when 'bands'
      %w(id name nick site wiki facebook twitter youtube soundcloud myspace purevolume lastfm instagram tumblr)
    when 'labels'
      %w(id name nick site youtube)
    else
      []
    end
  end
  
  def self.all(name)
    items = DB[name.to_sym]
    if name == 'posts'
      result = []
      result += items.where(:date => "").all
      result += items.where('date is not ""').order(Sequel.desc(:date)).all
    else
      items.all
    end
    
  end
  
  def self.add(name, params)
    items = DB[name.to_sym]
    cols = CommonModel.cols(name).map {|col| [col.to_sym, params[col.to_sym]]}
    items.insert(Hash[*cols.flatten])
  end
  
  def initialize(name, id)
    items = DB[name.to_sym]
    @name = name;
    @item = items.where(:id => id)
  end
  
  def to_h
    @item.first
  end
  
  def update(params)
    p params
    p @name
    cols = CommonModel.cols(@name).map {|col| [col.to_sym, params[col.to_sym]]}
    p Hash[*cols.flatten]
    @item.update(Hash[*cols.flatten])
  end
  
  def delete
    @item.delete
  end
end
