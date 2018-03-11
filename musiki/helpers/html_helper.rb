module HtmlHelper
  def head(title, level = 0)
    html = <<-"EOS"
      <meta charset="utf-8">
      <title>#{title}</title>
      <meta name="viewport" content="width=device-width,initial-scale=1">
      <link href="./#{"../"*level}assets/style.css" media="all" rel="stylesheet" />
      <script src="./#{"../"*level}assets/script.js" async></script>
    EOS
    html
  end

  def header(level = 0)
    html = <<-"EOS"
      <header>
        <h1><a href="./#{"../"*level}index.html">G-ROCK</a></h1>
        <ul>
          <li><a href="./#{"../"*level}bands.html">Bands</a></li>
          <li><a href="./#{"../"*level}discs.html">Discs</a></li>
          <li><a href="./#{"../"*level}labels.html">Labels</a></li>
          <li><a href="./#{"../"*level}songs.html">Songs</a></li>
          <li><a href="./#{"../"*level}members.html">Members</a></li>
        </ul>
        <div><a href="#" onclick="openMenu()">MENU</a></div>
      </header>
    EOS
  end
end
