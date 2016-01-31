module ViewUtils
  def link(url, title=nil, blank=false)
    if url.nil? || url.empty?
      blank ? '' : (title ||= url)
    else
      "<a href='#{url}' target='_blank'>#{title ||= url}</a>"
    end
  end
end
