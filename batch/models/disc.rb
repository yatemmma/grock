class Disc < Model
  def band_names(bands)
    bands.select {|band| @hash['bands'].split(',').include? band['ukey']}
         .map {|band| band['name']}
         .join(", ")
  end
  
  def release
    @hash['date']
  end
  
  def release_date
    date = @hash['date']
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
  
  def label_name(labels)
    label = labels.find {|label| @hash['label'] == label['ukey']}
    label.nil? ? "" : label['name']
  end
  
  def label_nick(labels)
    label = labels.find {|label| @hash['label'] == label['ukey']}
    label.nil? ? "" : label['nick']
  end
  
  def image_url
    if @hash['image'].empty?
      p "[WARN] No Image: #{@hash['ukey']}"
      "http://scream.your.name/images/no_image.jpg"
    else
      @hash['image']
    end
  end
  
  def listen_url
    return @hash['stream'] unless @hash['stream'].empty?
    return @hash['teaser'] unless @hash['teaser'].empty?
  end
  
  def itunes_link
    @hash['itunes']
  end
  
  def amazon_link
    if @hash['amazon'].empty?
      ""
    else
      if ENV['RAKE_ENV'] == "production"
        "http://www.amazon.co.jp/gp/product/#{@hash['amazon']}?ie=UTF8&tag=grock-22&link_code=wql"
      else
        "http://www.amazon.co.jp/gp/product/#{@hash['amazon']}"
      end
    end
  end
  
  def free_download
    @hash['free']
  end
end
