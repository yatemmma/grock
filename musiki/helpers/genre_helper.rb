module GenreHelper
  GENRES = {
    "post-hardcore": "Post-Hardcore"
  }

  def genre_name(code)
    result = GENRES[code]
    raise "Genre name not found. code:#{code}" if result.nil?
    result
  end
  def main_genre
    genres.nil? ? "" : GENRES[genres.first]
  end
end
