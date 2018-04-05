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
    prop :youtube, GVideo
    prop :original, GVideo
    prop :apple, GLink
    prop :play, GLink
    prop :spotify, GLink
    prop :links, GLink
    prop :guests, GGuest
    prop :body, GBody
    prop :public
    prop :memo

    def title
      #(type) band - name [year]
      words = []
      words << "(#{type.name})" unless type.name.nil?
      words << "#{band?.name}"
      words << "-"
      words << "#{name}"
      words << "[#{video_date.year}]" unless video_date.year.nil?
      words.join(" ")
    end

    def guest(code)
      self.class.alldata("member")[code]
    end

    def videos
      [youtube]
    end

    def search_link
      nil
    end

    def json
      data = {
        name: name,
        band: band,
        type: type.name,
        note: ""
      }.to_json
    end
  end
end
