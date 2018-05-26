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
end
