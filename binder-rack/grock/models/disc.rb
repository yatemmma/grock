require_relative "../submodels/models"
require_relative "../../core/models/metadata"

module GROCK
  class Disc < BinderRack::Core::Metadata
    prop :code
    prop :name, GName
    prop :band

    prop :type, GDiscType
    prop :date, GDate
    prop :label
    prop :videos, GVideo
    prop :images, GImage
    prop :apple, GLink
    prop :play, GLink
    prop :spotify, GLink
    prop :amazon, GLink
    prop :discogs, GLink
    prop :youtube, GLink
    prop :links, GLink
    prop :songs
    prop :guests
    prop :body, GBody
    prop :public
    prop :memo

    def json
      data = {
        name: name,
        band: band,
        date: date || "",
        type: type || "",
        note: ""
      }.to_json
    end
  end
end
