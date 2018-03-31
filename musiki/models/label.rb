require "./musiki/models/metadata"

class Label < Metadata
  prop :code
  prop :name
  prop :main_youtube
  prop :website
  prop :wikipedia
  prop :youtube
  prop :links
  prop :images
  prop :body
  prop :public
  prop :memo

  def id
    "label"
  end

  def title
    name
  end

  def json
    data = {
      name: name,
      note: ""
    }.to_json
  end
end
