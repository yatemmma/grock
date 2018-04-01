require_relative "../submodels/models"
require_relative "../../core/models/metadata"

module GROCK
  class Member < BinderRack::Core::Metadata
    prop :code
    prop :name, GName
    prop :description, GText
    prop :origin, GText
    prop :country, GCountry
    prop :videos, GVideo
    prop :images, GImage
    prop :links, GLink
    prop :bands
    prop :songs
    prop :body, GBody
    prop :public
    prop :memo

    def title
      name.to_s
    end

    def country_origin
      words = []
      words << country.emoji unless country.emoji.nil?
      words << origin.to_s unless origin.to_s.nil?
      words.join(" ")
    end

    def json
      data = {
        name: name,
        country: country.name || "",
        note: ""
      }.to_json
    end
  end
end
