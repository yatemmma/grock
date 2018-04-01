require_relative "../submodels/models"
require_relative "../../core/models/metadata"

module GROCK
  class Label < BinderRack::Core::Metadata
    prop :code
    prop :name, GName
    prop :videos, GVideo
    prop :images, GImage

    prop :website, GLink
    prop :wikipedia, GLink
    prop :youtube, GLink
    prop :links, GLink

    prop :body, GBody
    prop :public
    prop :memo


    def json
      data = {
        name: name,
        note: ""
      }.to_json
    end
  end
end
