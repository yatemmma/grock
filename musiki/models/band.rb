class Band
  def initialize
    @metadata = {}
  end

  def method_missing(method, *args)

  end

  def method_missing2(method, *args)
    key = method.to_s
    if SINGLE_PROPS.include? key
      return @metadata[key]
    end
    if MULTI_PROPS.include? key
      return @metadata.has_key?(key) ? @metadata : []
    end

    key = method.to_s.gsub("=", "")
    if SINGLE_PROPS.include? key
      return @metadata[key] = args.first
    end
    if MULTI_PROPS.include? key
      if @metadata.has_key?(key)
        return @metadata[key] = args
      else
        return @metadata[key] += args
      end
    end

    puts "[Error] unknown method called: #{method}, #{args}"
  end
end
