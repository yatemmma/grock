require "countries"

module GROCK
  class GCountry
    def initialize(data)
      @data = data
    end

    def name
      if @data.nil?
        nil
      elsif @data.to_s == "us"
        "USA"
      else
        c = ISO3166::Country.new(@data)
        c.name
      end
    end

    def emoji
      if @data.nil?
        nil
      else
        c = ISO3166::Country.new(@data)
        c.emoji_flag
      end
    end

    def to_s
      @data
    end
  end
end
