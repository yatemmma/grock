require_relative "../submodels/models"
require_relative "../../core/models/metadata"

module GROCK
  class Member < BinderRack::Core::Metadata
    prop :code
    prop :name, GName
    prop :description
    prop :origin
    prop :country, GCountry
    prop :videos, GVideo
    prop :images, GImage
    prop :links, GLink
    prop :bands
    prop :songs
    prop :body, GBody
    prop :public
    prop :memo

    def json
      data = {
        name: name,
        country: country.name || "",
        note: ""
      }.to_json
    end
  end
end
