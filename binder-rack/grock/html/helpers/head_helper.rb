module GROCK
  module HeadHelper
    def head(title = nil)
      header_title = [title, "G-ROCK"].compact.join(" | ")

      html = <<-"EOS"
        <meta charset="utf-8">
        <title>#{header_title}</title>
        <link rel="shortcut icon" type="image/x-icon" href="#{link "assets/images/favicon.ico"}" />
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="#{link "assets/style.css"}" media="all" rel="stylesheet" />
        <link href="#{link "assets/vendor/css/fontawesome-all.min.css"}" media="all" rel="stylesheet" />
        <script src="#{link "assets/script.js"}" async></script>
      EOS
    end
  end
end
