require "active_support/inflector"

class String
  def singular?
    self.singularize == self
  end
end

class Metadata
  def initialize(text)
    @metadata = {}
    text.scan(/(\[.*\])/) do |item|
      key, val = item.first[1..-2].split(":", 2)
      @metadata[key.to_sym] = val
    end
  end

  def []=(key, val)
    @metadata[key.to_sym] = val
  end

  # def []<<(key, val)
  #   if key.to_s.singular?
  #     @metadata[key.to_sym] = val
  #   else
  #     if @metadata.has_key? key.to_sym
  #       @metadata[key.to_sym] << val
  #     else
  #       @metadata[key.to_sym] = [val]
  #     end
  #   end
  # end

  def [](key)
    @metadata[key.to_sym]
  end

  def to_s
    @metadata.to_s
  end

  def method_missing(method, *args)
    if method[-1] == "="
      self[method] = args
    elsif method[-2, 2] == "<<"
      self[method] << args
    else
      self[method]
    end
  end
end
