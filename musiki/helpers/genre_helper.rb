module GenreHelper
  GENRES = {
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
end
