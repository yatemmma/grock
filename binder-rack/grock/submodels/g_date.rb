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

    def to_x
      year, month, day = @data.split("/")
      return "#{year}/99/99" if month.nil?
      return "#{year}/06/99" if month == "spring"
      return "#{year}/09/99" if month == "summer"
      return "#{year}/12/99" if month == "autumn"
      return "#{year}/03/99" if month == "winter"
      return "#{year}/#{month}/99" if day.nil?
      @data.to_s
    end

    def <=>(another)
      self.to_x <=> another.to_x
    end

    def to_s
      @data
    end
  end
end
