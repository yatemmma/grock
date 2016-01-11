require 'redcarpet/compat'
require 'pry-byebug'

class HTMLRenderer < Redcarpet::Render::HTML
  def initialize(extensions = {})
    @bands = extensions[:bands]
    super extensions.merge(link_attributes: {target: "_blank"})
  end
  
  def postprocess(full_document)
    # youtube
    full_document = full_document.gsub(/<p>youtube:(.+)<\/p>/, '<div class="media center"><iframe src="https://www.youtube.com/embed/\1" frameborder="0" allowfullscreen></iframe></div>')
    
    # band link
    band_link = /<a href=\":([^:]+):\" target=\"_blank\">([^<]+)<\/a>/
    matched = full_document.scan(band_link) # [["used", "The Used"],["dance_gavin_dance", "Dance Gavin Dacnce"]]
    matched.each do |m|
      id, name = m
      if @bands.find {|band| band['id'] == id}
        full_document = full_document.gsub("<a href=\":#{id}:\" target=\"_blank\">#{name}<\/a>", "<a href=\"http://scream.your.name/bands/#{id}.html\">#{name}</a>")
      else
        p "[WARN] Band Not Found: #{id}"
        full_document = full_document.gsub("<a href=\":#{id}:\" target=\"_blank\">#{name}<\/a>", name)
      end
    end
    
    full_document
  end
end

class Post < Model
  def sns_url
    "http://scream.your.name/posts/#{@hash['url']}.html"
  end
  
  def sns_title
    "G-ROCK #{@hash['title']}"
  end
  
  def has_media?
    @hash['media']
  end
  
  def media
    renderer = HTMLRenderer.new
    @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    @markdown.render(@hash['media'])
  end
  
  def body(bands=[])
    renderer = HTMLRenderer.new({:bands => bands})
    @markdown = Redcarpet::Markdown.new(renderer, {autolink: true, tables: true})
    @markdown.render(@hash['body'])
  end
  
  def relational_band_names
    @hash['bands'].split(',')
  end
  
  def relational_bands(bands)
    rel_band_names = relational_band_names
    selected = bands.select {|band| rel_band_names.include? band['id']}
    unless selected.size == rel_band_names.size
      p "[WARN] Band Not Found: #{rel_band_names - selected.map {|x| x['id']}}"
    end
    selected
  end
end
