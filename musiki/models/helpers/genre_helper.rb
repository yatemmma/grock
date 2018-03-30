module GenreHelper
  GENRES = {
    "acoustic":      "Acoustic",
    "indie-rock":    "Indie Rock",
    "post-hardcore": "Post-Hardcore"
  }

  def genre_name(code)
    result = GENRES[code.to_sym]
    raise "Genre name not found. code:#{code}" if result.nil?
    result
  end

  def main_genre
    if genres.nil?
      ""
    elsif genres.is_a? String
      genre_name(genres)
    else
      genre_name(genres.first)
    end
  end

  def all_genres
    if genres.nil?
      nil
    elsif genres.is_a? String
      genre_name(genres)
    else
      genres.map {|genre| genre_name(genre) }
            .join(", ")
    end
  end
end
