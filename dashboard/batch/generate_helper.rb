require 'redcarpet/compat'

module Grock
  
  class Template
    def initialize(locals)
      locals.each {|key, val|
        self.class.send(:define_method, key) { val }
      }
    end
    
    def partial(name, locals={})
      locals.each {|key, val|
        self.class.send(:define_method, key) { val }
      }
      begin
        ERB.new(File.read("templates/partials/_#{name}.erb"), nil, nil, eoutvar='_erbout2').result(binding)
      rescue => e
        puts "templates/partials/_#{name}.erb"
        raise e
      end
    end
    
    def recommends(items)
      groups = items.group_by {|item| item[:recommend]}
      recommend_items = []
      (5..10).each do |level|
        recommend_items += groups[level.to_s].shuffle.slice(0, level) unless groups[level.to_s].nil?
      end
      recommend_items.shuffle.slice(0, 9)
    end
    
    def development?
      ENV['APP_ENV'] == 'development'
    end
    
    def production?
      ENV['APP_ENV'] == 'production'
    end
  end
  
  class Item
    @@label_hash = {}
    @@band_hash = {}
    @@band_discs = {}
    @@band_posts = {}
    
    def self.label_hash(key, value)
      @@label_hash[key] = value
    end
    
    def self.band_hash(key, value)
      @@band_hash[key] = value
    end
    
    def self.band_discs(key, value)
      @@band_discs[key] = [] if @@band_discs[key].nil?
      @@band_discs[key] << value
    end
    
    def self.band_posts(key, value)
      @@band_posts[key] = [] if @@band_posts[key].nil?
      @@band_posts[key] << value
    end
  
    def initialize(hash)
      @hash = hash
    end
    
    def [](key)
      @hash[key.to_s]
    end
    
    def []=(key, value)
      @hash[key.to_s] = value
    end
    
    def bands
      @hash['bands'].split(',')
    end
    
    def band_names
      bands.map {|key| @@band_hash[key][:name]}.join(', ')
    end
    
    def label_name
      label = @@band_hash[@hash['label']]
      label.nil? ? '' : label[:name]
    end
    
    def label_nick
      label = @@band_hash[@hash['label']]
      label.nil? ? '' : label[:nick]
    end
    
    def related_bands
      bands.map {|key| @@band_hash[key]}
    end
    
    def related_discs_for_band
      @@band_discs[@hash['key']] || []
    end
    
    def related_posts_for_band
      @@band_posts[@hash['key']] || []
    end
    
    def link(key)
      return nil if @hash[key.to_s].nil? || @hash[key.to_s].empty?
      @hash[key.to_s]
    end
    
    def image_url
      if @hash['image'].empty?
        p "[WARN] No Image: #{@hash['key']}"
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
        if ENV['APP_ENV'] == "production"
          "http://www.amazon.co.jp/gp/product/#{@hash['amazon']}?ie=UTF8&tag=#{ENV['AMAZON_ASSOCIATES_TAG']}&link_code=wql"
        else
          "http://www.amazon.co.jp/gp/product/#{@hash['amazon']}"
        end
      end
    end
    
    def free_download
      @hash['free']
    end
    def release_date
      date = @hash['date']
  		if date.size == 10 #2015/10/18
  			Date.strptime(date, "%Y/%m/%d")
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
    
    def sns_url
      "http://scream.your.name/posts/#{@hash['key']}.html"
    end
    
    def sns_title
      "G-ROCK #{@hash['title']}"
    end
    
    def has_media?
      @hash['media']
    end
    
    def media
      renderer = HTMLRenderer.new
      @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
      @markdown.render(@hash['media'])
    end
    
    def body(bands=[])
      renderer = HTMLRenderer.new({:bands => bands})
      @markdown = Redcarpet::Markdown.new(renderer, {autolink: true, tables: true})
      @markdown.render(@hash['body'])
    end
    
    def relational_band_names
      @hash['bands'].split(',')
    end
    
    def relational_bands(bands)
      rel_band_names = relational_band_names
      selected = bands.select {|band| rel_band_names.include? band['key']}
      unless selected.size == rel_band_names.size
        p "[WARN] Band Not Found: #{rel_band_names - selected.map {|x| x['key']}}"
      end
      selected
    end
  end

  class HTMLRenderer < Redcarpet::Render::HTML
    def initialize(extensions = {})
      @bands = extensions[:bands]
      super extensions.merge(link_attributes: {target: "_blank"})
    end
    
    def postprocess(full_document)
      # youtube
      full_document = full_document.gsub(/<p>youtube:(.+)<\/p>/, '<div class="media center"><iframe src="https://www.youtube.com/embed/\1" frameborder="0" allowfullscreen></iframe></div>')
      
      # band link
      band_link = /<a href=\":([^:]+):\" target=\"_blank\">([^<]+)<\/a>/
      matched = full_document.scan(band_link) # [["used", "The Used"],["dance_gavin_dance", "Dance Gavin Dacnce"]]
      matched.each do |m|
        key, name = m
        if @bands.find {|band| band[:key] == key}
          full_document = full_document.gsub("<a href=\":#{key}:\" target=\"_blank\">#{name}<\/a>", "<a href=\"http://scream.your.name/bands/#{key}.html\">#{name}</a>")
        else
          p "[WARN] Band Not Found: #{key}"
          full_document = full_document.gsub("<a href=\":#{key}:\" target=\"_blank\">#{name}<\/a>", name)
        end
      end
      
      full_document
    end
  end
end
