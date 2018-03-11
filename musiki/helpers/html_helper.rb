module HtmlHelper
  def headers(title, level = 0)
    html = <<-"EOS"
      <meta charset="utf-8">
      <title>#{title}</title>
      <meta name="viewport" content="width=device-width,initial-scale=1">
      <link href="./#{"../"*level}assets/style.css" media="all" rel="stylesheet" />
      <script src="./#{"../"*level}assets/script.js" async></script>
    EOS
    html
  end
end
