require 'yaml'

class Label

	@@labels = nil

	def self.load
		puts "--info: label data loaded."
		raw_data = YAML.load_file('data/labels.yml')
		@@labels = raw_data.map {|key, value| [key, Label.new(key, value)]}.to_h
	end

	def self.all
		@@labels ||= load
	end

	def self.get_label(label_key)
		all[label_key.to_sym]
	end

	attr_reader :name, :nick, :youtube

	def initialize(key, label)
		@name = label[:name]
		@nick = label[:nick]
		@youtube = label[:youtube]
	end
end
