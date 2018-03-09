require "countries"

module CountryHelper
  def country_name(code)
    c = ISO3166::Country.new(code)
    c.name
  end

  def country_emoji(code)
    c = ISO3166::Country.new(code)
    c.emoji_flag
  end
end
