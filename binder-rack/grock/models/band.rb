require_relative "../submodels/models"
require_relative "../../core/models/metadata"

module GROCK
  class Band < BinderRack::Core::Metadata
    prop :code
    prop :name, GName
    prop :description, GText
    prop :origin, GText
    prop :country, GCountry
    prop :active, GActive
    prop :genres, GGenre
    prop :videos, GVideo
    prop :images, GImage
    prop :apple, GLink
    prop :play, GLink
    prop :spotify, GLink
    prop :soundcloud, GLink
    prop :bandcamp, GLink
    prop :youtube, GLink
    prop :website, GLink
    prop :wikipedia, GLink
    prop :twitter, GLink
    prop :facebook, GLink
    prop :instagram, GLink
    prop :purevolume, GLink
    prop :myspace, GLink
    prop :discogs, GLink
    prop :links, GLink
    prop :members
    prop :past_members
    prop :discs
    prop :body, GBody
    prop :public
    prop :memo

    def title
      words = []
      words << name
      words << "(#{active.short})" unless active.short.nil?
      words.join(" ")
    end

    def country_origin
      words = []
      words << country.emoji unless country.emoji.nil?
      words << origin.to_s unless origin.to_s.nil?
      words.join(" ")
    end

    def all_genres
      genres.map {|genre| genre.name }
    end

    def json
      data = {
        name: name,
        country: country.name || "",
        active: active.short || "",
        genre: genres.first || "",
        note: ""
      }.to_json
    end
  end
end
