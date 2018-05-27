class Band < ActiveRecord::Base
	self.primary_key = :code

	include BaseModel

	class << self
		def site_keys
			%w(apple play spotify soundcloud bandcamp amazon website wikipedia youtube twitter facebook instagram purevolume myspace lastfm discogs)
		end

		def all_items
			self.order("name")
		end
	end

	def title
		self.name || ""
	end

	def active_text
		return "" if self.active.nil?
		return "#{self.active}present" if self.active.end_with? "-"
		self.active
	end

	def active_short_text
		return "" if self.active.nil?
		start = self.active.split("-", -1).first
		last = self.active.split("-", -1).last
		"#{start}-#{last.empty? ? "present" : last}"
	end
end
