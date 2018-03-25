module ActiveHelper
  def active_short
    if active.nil?
      ""
    else
      text = (active[-1] == "-") ? "#{active}present" : active
      text.split("-").first.strip + "-" + text.split("-").last.strip
    end
  end
end
