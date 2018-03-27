require "yaml"

module FeedHTMLHelper
  def feeds(band)
    path = "info/feeds/feed##{band.code}.yaml"
    data_list = YAML.load_file(path) if File.exists? path
    feed_num = 20

    html_list = (data_list || [])[0, feed_num].map do |data|
      feed(data)
    end
    html = <<-"EOS"
      <div class="feeds">
        #{html_list.join("\n")}
      </div>
    EOS
  end

  def feed(data)
    html = <<-"EOS"
      <div class="feed">
        <a class="title" href="#{data[:url]}" target="_blank">#{data[:title]}</a>
        <div class="date">#{data[:date]}</div>
        <div class="body">#{data[:body]}</div>
      </div>
    EOS
  end
end
