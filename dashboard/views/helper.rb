module ViewUtils
  def link(url, title=nil)
    if url
      "<a href='#{url}' target='_blank'>#{title ||= url}</a>"
    else
      title ||= url
    end
  end
end
