class Label < ActiveRecord::Base
	self.primary_key = :code

	class << self
		def site_keys
			%w(website wikipedia youtube twitter facebook)
		end
	end

	def title
		self.name
	end

	def feeds
		[]
	end

	def main_image
		self.images.split(",").first
	end

	def link_list
		self.links.split(",")
	end
end
