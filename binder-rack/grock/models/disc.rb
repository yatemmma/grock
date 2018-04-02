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

    def title
      # band - name type (year)
      words = []
      words << "[#{type.short_name}]" unless type.short_name.nil?
      words << band?.name
      words << "-"
      words << name
      words << "(#{date.year})" unless date.year.nil?
      words.join(" ")
    end

    def search_link
      text = URI.encode_www_form_component("#{band?.name} #{name} full album")
      data = {
        "title" => "#{band?.name} - #{name}",
        "url" => "https://www.youtube.com/results?search_query=" + text
      }
      GLink.new(data)
    end

    def guests
      song_list = self.class.alldata("song")
      song_list.select do |song_code, song|
         (song.disc == code) && (song.type.to_s == "guest")
      end.values.reverse.map {|song| [song.guest(song.guests.first.code), song.guests.first.label]}
    end

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
