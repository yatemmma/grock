class Feed < ActiveRecord::Base
	self.primary_key = :code

	def icon_image
		matched = self.icon.match(/^<url>(.*)<\/url>$/) unless self.icon.nil?
		matched[1] unless matched.nil?
	end

	def youtube_video_key
		if self.feed_type == "youtube"
			self.url.split("/").last.split("=").last
		end
	end
end
