require 'slim'

require 'label'
require 'band'
require 'disc'
require 'post'
require 'helper'

class GRock

  include Helper

  PUBLIC_DIR = 'public'

	def initialize
    @posts  = Post.all
    @url = "https://scream.your.name"
    @page = {:path => ".", :is_top => true}
	end

  def run
    generate_post_page
    generate_posts_page
    generate_labels_page
    generate_discs_page
    generate_bands_page
    generate_404_page
  end

  def generate_post_page
    @posts.each_with_index do |post, i|
      @page = {:path => "..", :is_top => false}
      params = {
      	:post => post,
      	:prev_post => i == 0 ? nil : @posts[i-1],
      	:next_post => i == @posts.size-1 ? nil : @posts[i+1],
      }
      html = template :post, params
      File.write("#{PUBLIC_DIR}/posts/#{post.key}.html", html)
      if i == 0
        @page = {:path => ".", :is_top => true}
        html = template :post, params
        File.write("#{PUBLIC_DIR}/index.html", html) 
      end
    end
  end

  def generate_posts_page
    @page = {:path => ".", :is_top => true}
    html = template :posts
    File.write("#{PUBLIC_DIR}/posts.html", html)
  end

  def generate_labels_page
    @page = {:path => ".", :is_top => true}
    html = template :labels
    File.write("#{PUBLIC_DIR}/labels.html", html)
  end

  def generate_discs_page
    @page = {:path => ".", :is_top => true}
    html = template :discs
    File.write("#{PUBLIC_DIR}/discs.html", html)
  end

  def generate_bands_page
    @page = {:path => ".", :is_top => true}
    html = template :bands
    File.write("#{PUBLIC_DIR}/bands.html", html)
  end

  def generate_404_page
    @page = {:path => ".", :is_top => true}
    html = template '404'
    File.write("#{PUBLIC_DIR}/404.html", html)
  end
end
