module BodyHTMLHelper
  def body(item)
    html = <<-"EOS"
      <div class="body">
        #{item.body}
      </div>
    EOS
  end
end
