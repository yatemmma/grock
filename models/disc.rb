class Disc < ActiveRecord::Base
	self.primary_key = :code

	def all_links
		JSON.parse(links || "[]").reject {|x| x.nil? || x.empty?}
	end

	def all_feeds
		band_code = bands.split(",").first unless bands.nil?
		band = Band.find_by(code: band_code)
		band.nil? ? [] : JSON.parse(band.feeds || "[]")
	end

	def all_songs
		JSON.parse(songs || "[]").reject {|x| x.nil? || x.empty?}
	end

	def all_guests
		JSON.parse(guests || "[]").reject {|x| x.nil? || x.empty?}
	end

	def title
		name || ""
	end

	def date_name
		text, additonal = date.split(" ")
		text += " " + date_labels[additonal] unless additonal.nil?
		text
	end

	def band_name
		band_code = bands.split(",").first unless bands.nil?
		band = Band.find_by(code: band_code)
		band.nil? ? "" : band.name
	end

	def genres_text
		(genres || "").split(",").map{|x| genre_labels[x]}.join(", ")
	end

	def search_data
		{
			search: {
				code: code,
				name: name,
				band: band_name,
				type: disc_types[disc_type],
				date: date_name,
				genre: genres_text
			},
			display: {
				code: code,
				name: name,
				band: band_name,
				type: disc_types[disc_type],
				date: date_name,
				genre: genres_text
			}
		}
	end

	def self.search_json
		Disc.all.map {|x| x.search_data}.to_json
	end
end
