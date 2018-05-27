require "json"

class Setting < ActiveRecord::Base
	self.primary_key = :code

	class << self
		def genres
			self.find_by(code: "genres")
		end

		def sites
			self.find_by(code: "sites")
		end

		def disc_types
			self.find_by(code: "disc_types")
		end

		def date_labels
			self.find_by(code: "date_labels")
		end
	end

	def to_json
		JSON.pretty_generate(JSON.parse(self.json))
	end

	def to_hash
		JSON.parse(self.json)
	end
end
