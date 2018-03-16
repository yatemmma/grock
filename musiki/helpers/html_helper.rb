module HtmlHelper
  include SNSHelper
  def domain
    "https://scream.your.name/"
  end

  def head(title, level = 0)
    html = <<-"EOS"
      <meta charset="utf-8">
      <title>#{title}</title>
      <link rel="shortcut icon" type="image/x-icon" href="./#{"../"*level}assets/images/favicon.ico" />
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

  def sns(path, title, level = 0)
    html = <<-"EOS"
      <section class="sns">
        <a href="#{twitter_share_link(domain + path, title)}" target="_blank">
          <img src="./#{"../"*level}assets/images/share_twitter.png">
        </a>
      </section>
    EOS
  end

  def scripts(items)
    html = <<-"EOS"
      const originals = [#{items.map do |code, item|; item.json; end.join","}]
      let displayed = null
      const reversed = {}
      const filltered = {}
    EOS
  end
end
