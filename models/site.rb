module GROCK
  class Site < ActiveRecord::Base
    self.primary_key = :code
    self.inheritance_column = :_type_disabled

    def image
      GROCK::Image.where(kind: :site, code: self.code).first || GROCK::Image.new
    end

    def links
      GROCK::Link.where(kind: :site, code: self.code)
    end

    def tags
      GROCK::Tag.where(kind: :site, code: self.code)
    end
  end
end
