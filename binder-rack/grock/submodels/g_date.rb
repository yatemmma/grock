module GROCK
  class GDate
    def initialize(data)
      @data = data
    end

    def year
      if @data.nil?
        nil
      else
        @data.split("/").first
      end
    end

    def to_s
      @data
    end
  end
end
