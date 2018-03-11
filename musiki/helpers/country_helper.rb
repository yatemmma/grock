require "countries"

module CountryHelper
  def country_name
    c = ISO3166::Country.new(country)
    c.name
  end

  def country_emoji
    c = ISO3166::Country.new(country)
    c.emoji_flag
  end
end
