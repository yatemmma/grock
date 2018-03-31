module GROCK
  module HeadHelper
    def head(title = nil)
      header_title = [title, "G-ROCK"].compact.join(" | ")

      html = <<-"EOS"
        <meta charset="utf-8">
        <title>#{header_title}</title>
      EOS
    end
  end
end
