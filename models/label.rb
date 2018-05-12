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

		def search_json
			Label.all_items.map {|x|
				{
					code: x.code,
					name: x.name,
					country: x.origin,
					updated: x.updated_date
				}
			}.to_json
		end
	end

	def title
		self.name || ""
	end
end
