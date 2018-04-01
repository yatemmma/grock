module GROCK
  module HeaderFooterHelper
    def header
      html = <<-"EOS"
        <header>
          <h1><a href="#{link "index.html"}">G-ROCK</a></h1>
          <span><a target="#" onclick="toggleMenu()">Menu</a></span>
          <nav>
            <ul>
              <li><a href="#{link "bands.html"}">Band</a></li>
              <li><a href="#{link "discs.html"}">Disc</a></li>
              <li><a href="#{link "labels.html"}">Label</a></li>
              <li><a href="#{link "songs.html"}">Song</a></li>
              <li><a href="#{link "members.html"}">Member</a></li>
            </ul>
          </nav>
        </header>
      EOS
    end

    def footer
      created_at = Date.today.strftime("%Y")

      html = <<-"EOS"
        <footer>
          <div class="link">
            <a href="https://twitter.com/prettygereen" target="_blank"><i class="fab fa-twitter"></i></a>
          </div>
          <div class="copy">&copy; 2009-#{created_at} <a href="#{link "index.html"}">G-ROCK</a></div>
        </footer>
      EOS
    end

    def list_scripts(items)
      data = items.map {|code, item|
         item.json
      }.join(",")

      html = <<-"EOS"
        <script>
          const originals = [#{data}]
          let displayed = null
          const reversed = {}
          const filltered = {}
        </script>
      EOS
    end
  end
end
