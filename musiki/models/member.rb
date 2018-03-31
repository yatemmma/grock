require "./musiki/models/metadata"

class Member < Metadata
  prop :code
  prop :name
  prop :description
  prop :origin
  prop :country
  prop :main_youtube
  prop :images
  prop :links
  prop :bands
  prop :songs
  prop :body
  prop :public
  prop :memo

  def id
    "member"
  end

  def title
    name
  end

  def json
    data = {
      name: name,
      country: country_name,
      note: ""
    }.to_json
  end
end
