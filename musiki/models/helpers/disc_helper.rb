module DiscHelper
  DISC_TYPES = {
    "album":  "Album",
    "ep":     "EP",
    "single": "Single"
  }

  SONG_TYPES = {
    "music_video":  "Music Video"
  }

  def type_name
    DISC_TYPES[type.to_sym]
  end

  def song_type_name
    SONG_TYPES[type.to_sym]
  end
end
