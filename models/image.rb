module GROCK
  class Image < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
    
    def icon
      self.icon_url
    end

    def thumbnail
      self.thumbnail_url
    end

    def large
      self.large_url
    end
  end
end
