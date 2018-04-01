require_relative "../submodels/models"
require_relative "../../core/models/metadata"

module GROCK
  class Song < BinderRack::Core::Metadata
    prop :code
    prop :name, GName
    prop :band
    prop :disc
    prop :date, GDate
    prop :type, GSongType
    prop :label
    prop :video_date, GDate
    prop :youtube, GLink
    prop :apple, GLink
    prop :play, GLink
    prop :spotify, GLink
    prop :links, GLink
    prop :guests
    prop :body, GBody
    prop :public
    prop :memo

    def json
      data = {
        name: name,
        band: band,
        band: type.name,
        note: ""
      }.to_json
    end
  end
end
