require "active_support/inflector"

class String
  def singular?
    self.singularize == self
  end
end

class Metadata
  def initialize(text = "")
    @metadata = {}
    text.scan(/(\[.*\])/) do |item|
      key = item.first[1..-2].split(":", 2).first
      val = item.first[1..-2].split(":").last
      self[key] = val
    end
  end

  def []=(key, val)
    if key.to_s.singular? || val.nil?
      @metadata[key.to_sym] = val
    else
      @metadata[key.to_sym] = (val.instance_of? Array) ? val : [val]
    end
  end

  def [](key)
    @metadata[key.to_sym]
  end

  def set(key, val)
    self[key] = val
  end

  def get(key)
    self[key]
  end

  def add(key, val)
    if key.to_s.singular?
      self[key.to_sym] = val
    else
      if @metadata[key.to_sym].instance_of? Array
        if val.instance_of? Array
          @metadata[key.to_sym] += val
        elsif val.nil?
          # nop
        else
          @metadata[key.to_sym] << val
        end
      else
        @metadata[key.to_sym] = (val.nil? || (val.instance_of? Array)) ? val : [val]
      end
    end
  end

  def to_s
    @metadata.to_s
  end
end
