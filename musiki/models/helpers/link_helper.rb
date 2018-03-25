module LinkHelper
  LINKS = {
    "apple":      "Apple Music",
    "play":       "Play Music",
    "spotify":    "Spotify",
    "soundcloud": "SoundCloud",
    "bandcamp":   "BandCamp",
    "youtube":    "YouTube",
    "website":    "Website",
    "wikipedia":  "Wikipedia",
    "twitter":    "Twitter",
    "facebook":   "Facebook",
    "instagram":  "Instagram",
    "discogs":    "Discogs",
  }

  def link_type_name(key)
    LINKS[key.to_sym]
  end

end
