class Label < ActiveRecord::Base
	self.primary_key = :code

	def all_links
		JSON.parse(links || "[]").reject {|x| x.nil? || x.empty?}
	end

	def all_feeds
		JSON.parse(feeds || "[]")
	end

	def title
		name || ""
	end

	def search_data
		{
			search: {
				code: code,
				name: name
			},
			display: {
				code: code,
				name: name
			}
		}
	end

	def self.search_json
		Label.all.map {|x| x.search_data}.to_json
	end
end
