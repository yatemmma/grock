require "countries"

module CountryHelper
  def country_name
    if country.nil?
      ""
    else
      c = ISO3166::Country.new(country)
      c.name
    end
  end

  def country_emoji
    if country.nil?
      ""
    else
      c = ISO3166::Country.new(country)
      c.emoji_flag
    end
  end
end
