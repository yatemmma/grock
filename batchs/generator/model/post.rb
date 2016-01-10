require 'yaml'
require 'redcarpet/compat'

class HTMLRenderer < Redcarpet::Render::HTML
  def initialize(extensions = {})
    super extensions.merge(link_attributes: {target: "_blank"})
  end
end

class Post

	@@posts = nil

	def self.load
		puts "--info: post data loaded."
		@@posts = Dir::entries("data/posts/")
                  .select {|x| /.md$/ =~ x}
                  .map {|file_name| Post.new(file_name)}
                  .sort_by {|post| post.date}.reverse
	end

	def self.all
		@@posts ||= load
	end

	def self.band_posts(band)
		all.select {|post| post.band_keys.include?(band.key.to_s)}
	end

	attr_reader :key, :title, :date, :band_keys, :body, :youtube

	def initialize(file_name)
		@key = file_name[0...-3]
		data = YAML.load_file("data/posts/#{file_name}")
		@title = data[:title]
		@date  = data[:date]
		@band_keys = data[:bands]
		@type, @youtube = data[:type]
		markdown = Redcarpet::Markdown.new(HTMLRenderer, autolink: true, tables: true)
		@body = markdown.render(data[:body])
	end

	def bands
		@band_keys.map{|band_key| Band.get_band(band_key)}
	end
end
