require "./templates/helpers/erb_helper"

class Generator
  include ERBHelper

  def output_index
    @floor = 0
    html = erb :index, {title: nil}
    File.write("docs/index.html", html)
  end
end
