module GROCK
  class GActive
    def initialize(data)
      @data = data
    end

    def short
      if @data.nil?
        nil
      else
        text = (@data[-1] == "-") ? "#{@data}present" : @data
        text.split("-").first.strip + "-" + text.split("-").last.strip
      end
    end

    def full
      if @data.nil?
        nil
      else
        text = (@data[-1] == "-") ? "#{@data}present" : @data
        text
      end
    end

    def to_s
      @data
    end
  end
end
