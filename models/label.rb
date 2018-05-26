class Label < ActiveRecord::Base
	self.primary_key = :code

	include BaseModel

	class << self
		def site_keys
			%w(website wikipedia youtube twitter facebook)
		end

		def all_items
			self.order("name")
		end
	end

	def title
		self.name || ""
	end
end
