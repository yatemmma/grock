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
	end

	def title
		self.name || ""
	end

	def main_band_code
		self.bands.split(",").first unless self.bands.nil?
	end

	def main_band
		Band.find_by(code: self.main_band_code)
	end

	def main_original_band_code
		self.original_bands.split(",").first unless self.original_bands.nil?
	end

	def main_original_band
		Band.find_by(code: self.main_original_band_code) unless self.original_bands.nil?
	end

	def main_label_code
		self.labels.split(",").first unless self.labels.nil?
	end

	def main_label
		Label.find_by(code: self.main_label_code)
	end

	def date_text
		return nil if self.date.nil?
		y, m, d = self.date.split("/")
		if m == "99" && d == "99"
			"#{y}"
		elsif d == "99"
			"#{y}/#{m}"
		elsif m == "33"
			"#{y} Early"
		elsif m == "44"
			"#{y} Spring"
		elsif m == "55"
			"#{y} Summer"
		elsif m == "66"
			"#{y} Fall"
		elsif m == "77"
			"#{y} Winter"
		elsif m == "88"
			"#{y} Late"
		else
			self.date
		end
	end
end
