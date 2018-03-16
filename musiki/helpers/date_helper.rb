module DateHelper
  def date_year
    if date.nil?
      nil
    else
      date.split("/").first
    end
  end
end
