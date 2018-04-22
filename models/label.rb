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
end
