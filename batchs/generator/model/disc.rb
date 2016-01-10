require 'yaml'
require 'pry'

class Disc

	@@discs = nil
	@@recommend_discs = nil
	@@release_discs = nil

	def self.load
		puts "--info: disc data loaded."
		raw_data = []
		Dir::entries("data/discs/")
                  .select {|x| /.yml$/ =~ x}
                  .each {|file_name|
                  	raw_data += YAML.load_file("data/discs/#{file_name}")
                  }
		discs = raw_data.map{|disc| Disc.new(disc)}.sort_by{|disc| parse(disc.date)}.reverse

		@@recommend_discs = discs.select {|disc| disc.recommend}
		@@release_discs = new_release_disc(discs)

		@@discs = discs
	end

	def self.new_release_disc(discs)
		past_date_day = 30
		minimum_num = 3

		results = []
		discs.each do |disc|
			disc_date = 
			if (Date.today - parse(disc.date)).to_i <= past_date_day || results.size < minimum_num
				results << disc
			end
		end
		results.reverse
	end

	def self.parse(date)
		date = date.to_s
		if date.size == 10 #2015/10/18
			Date.strptime(date, "%Y/%M/%d")
		elsif date.size == 4 #2015
			Date.new(date.to_i, 12, 31)
		elsif date.size == 7 #2015/01
			y, m = date.split('/').map{|x| x.to_i}
			Date.new(y, m, -1)
		else # 2015 Summer
			y, season = date.split(' ')
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

	def self.all
		@@discs ||= load
	end

	def self.new_releases
		load if @@release_discs.nil?
		@@release_discs
	end

	def self.recommends(num=8)
		load if @@recommend_discs.nil?
		@@recommend_discs.shuffle[0,num]
	end

	def self.band_releases(band_key)
		all.select {|disc| disc.bands.include?(band_key.to_s)}
	end

	def self.label_releases(label_key)
		all.select {|disc| disc.label_key == label_key.to_s}[0,8]
	end

	attr_reader :title, :bands, :date, :label, :label_key, :image, :amazon, :free
	attr_reader :itunes, :stream, :teaser, :band_names, :recommend


	def initialize(disc)
		@title   = disc[:title]
		@bands   = disc[:bands]
		@date    = disc[:date]
		@label_key = disc[:label]
		@label   = Label.get_label(disc[:label]).nick if disc[:label]
		@image   = disc[:image]
		@free  = disc[:free]
		@amazon  = disc[:amazon]
		@itunes  = disc[:itunes]
		@stream  = disc[:stream]
		@teaser  = disc[:teaser]
		@recommend = disc[:recommend]

		@band_names = @bands.map{|band_key| Band.get_band(band_key).name}.join(", ")
	end

	def listen
		@stream ||= @teaser
	end

	def amazon_link
		"http://www.amazon.co.jp/gp/product/#{@amazon}?ie=UTF8&tag=grock-22&link_code=wql" unless @amazon.nil?
	end

	def itunes_link
		@itunes
	end

	def buy_link
		if amazon_link.nil?
			@itunes
		else
			amazon_link
		end
	end

	def sample_link
		@stream ||= @teaser
	end

	def image_link(rel_path)
		@image ||= "#{rel_path}/images/no_image.jpg"
	end
end
