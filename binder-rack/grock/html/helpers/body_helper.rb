module GROCK
  module BodyHelper
    def body_block(item)
      html = <<-"EOS"
        <div class="body">
          #{item.body.to_s}
        </div>
      EOS
    end
  end
end
