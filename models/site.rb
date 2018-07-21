module GROCK
  class Site < ActiveRecord::Base
    self.primary_key = :code
    self.inheritance_column = :_type_disabled

    def image
      GROCK::Image.where(kind: :site, code: self.code).first
    end

    def links
      GROCK::Link.where(kind: :site, code: self.code)
    end

    def tags
      GROCK::Tag.where(kind: :site, code: self.code)
    end

    def sources
      GROCK::Source.where(kind: :site, code: self.code).order(:created_at)
    end
  end
end
