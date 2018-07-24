module GROCK
  class Label < ActiveRecord::Base
    self.primary_key = :code
    self.inheritance_column = :_type_disabled

    def image
      GROCK::Image.where(kind: :label, code: self.code).first || GROCK::Image.new
    end

    def links
      GROCK::Link.where(kind: :label, code: self.code)
    end

    def tags
      GROCK::Tag.where(kind: :label, code: self.code)
    end

    def sources
      GROCK::Source.where(kind: :label, code: self.code).order(:created_at)
    end

    def feeds
      GROCK::Feed.where(kind: :label, code: self.code).order(:created_at)
    end
  end
end
