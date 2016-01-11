class CommonModel
  def self.cols(name)
    case name
    when 'posts'
      %w(id url title date bands type media recommend body)
    when 'discs'
      %w(id title bands date label image amazon itunes stream teaser free recommend)
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
  
  def self.release_date(date)
		if date.size == 10 #2015/10/18
			Date.strptime(date, "%Y/%M/%d")
		elsif date.size == 4 #2015
			Date.new(date.to_i, 12, 31)
		elsif date.size == 7 #2015/01
			y, m = date.split('/').map{|x| x.to_i}
			Date.new(y, m, -1)
		else # 2015/Summer
			y, season = date.split('/')
			case season
			when 'Spring'
				Date.new(y.to_i, 3, -1)
			when 'Summer'
				Date.new(y.to_i, 6, -1)
			when 'Autumn'
				Date.new(y.to_i, 9, -1)
			when 'Winter'
				Date.new(y.to_i, 12, 30)
			else
				raise "bad format"
			end
		end
  end
  
  def self.all(name)
    items = DB[name.to_sym]
    if name == 'posts'
      result = []
      result += items.where(:date => "").all
      result += items.exclude(:date => "").order(Sequel.desc(:date)).all
    elsif name == 'discs'
      sorted = items.all.sort do |a, b|
        p a
        a_date = CommonModel.release_date a[:date]
        b_date = CommonModel.release_date b[:date]
        a_date <=> b_date
      end
      sorted.reverse
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
