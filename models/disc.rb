class Disc < ActiveRecord::Base
	self.primary_key = :code

	include BaseModel

	class << self
		def site_keys
			%w(apple play spotify soundcloud bandcamp amazon wikipedia lastfm discogs teaser playlist search)
		end

		def all_items
			self.order("name")
		end

		def search_json
			Band.all_items.map {|x|
				{
					code: x.code,
					name: x.name,
					updated: x.updated_date
				}
			}.to_json
		end
	end

	def title
		self.name || ""
	end

	def main_band_code
		self.bands.split(" ").first unless self.bands.nil?
	end

	def main_band
		Band.find_by(code: self.main_band_code)
	end

	def main_label_code
		self.labels.split(" ").first unless self.labels.nil?
	end

	def main_label
		Label.find_by(code: self.main_label_code)
	end
end
