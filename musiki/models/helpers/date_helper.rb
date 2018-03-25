module DateHelper
  def date_year
    if date.nil?
      nil
    else
      date.split("/").first
    end
  end

  def video_date_year
    if video_date.nil?
      nil
    else
      video_date.split("/").first
    end
  end
end
