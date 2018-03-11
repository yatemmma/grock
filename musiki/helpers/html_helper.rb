module HtmlHelper
  def head(title, level = 0)
    html = <<-"EOS"
      <meta charset="utf-8">
      <title>#{title}</title>
      <meta name="viewport" content="width=device-width,initial-scale=1">
      <link href="./#{"../"*level}assets/style.css" media="all" rel="stylesheet" />
      <link href="./#{"../"*level}assets/vendor/css/fontawesome-all.min.css" media="all" rel="stylesheet" />
      <script src="./#{"../"*level}assets/script.js" async></script>
    EOS
  end

  def header(level = 0)
    html = <<-"EOS"
      <header>
        <h1><a href="./#{"../"*level}index.html">G-ROCK</a></h1>
        <ul class="default">
          <li><a href="./#{"../"*level}bands.html">Band</a></li>
          <li><a href="./#{"../"*level}discs.html">Disc</a></li>
          <li><a href="./#{"../"*level}labels.html">Label</a></li>
          <li><a href="./#{"../"*level}songs.html">Song</a></li>
          <li><a href="./#{"../"*level}members.html">Member</a></li>
          <li class="close"><a href="#" onclick="toggleMenu()">[x] close</a></li>
        </ul>
        <div><a href="#" onclick="toggleMenu()">MENU</a></div>
      </header>
    EOS
  end

  def footer(level = 0)
    html = <<-"EOS"
      <footer>
        <div class="link">
          <a href="https://twitter.com/prettygereen" target="_blank"><i class="fab fa-twitter"></i></a>
        </div>
        <div class="copy">&copy; 2009-#{Date.today.strftime("%Y")} <a href="./#{"../"*level}index.html">G-ROCK</a></div>
      </footer>
    EOS
  end
end
