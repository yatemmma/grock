require "fileutils"
require "./templates/helpers/erb_helper"

class Generator
  include ERBHelper
  def output_list_page
    @floor = 0
    %w(index bands members discs covers labels).each do |types|
      html = get_html(types)
      File.write("docs/#{types}.html", html)
    end
  end

  def output_pages
    @floor = 1
    %w(band disc label).each do |type|
      FileUtils.rm_rf "docs/#{type}"
      FileUtils.mkdir_p "docs/#{type}"
      clazz = Object.const_get(type.capitalize)
      clazz.all.each do |item|
        @item = clazz.find_by(code: item.code)
        html = erb type.to_sym, {title: item.name}
        File.write("docs/#{type}/#{item.code}.html", html)
      end
    end
  end

  def get_html(types)
    case types
    when "index"
      erb :index, {title: nil}
    when "bands"
      @items = Band.all_items.select {|x| p x.genres;(x.member_of.empty? && x.ex_member_of.empty? && (x.genres != "covered"))}
      erb :bands, {title: "Bands"}
    when "members"
      @items = Band.all_items.select {|x| (not x.member_of.empty?) || (not x.ex_member_of.empty?)}
      erb :members, {title: "Members"}
    when "discs"
      @items = Disc.all_items.reject {|x| (x.genres.start_with? "cover")}
      erb :discs, {title: "Discs"}
    when "covers"
      @items = Disc.all_items.select {|x| (x.genres.start_with? "cover")}
      erb :covers, {title: "Covers"}
    else
      clazz = Object.const_get(types.singularize.capitalize)
      @items = clazz.all_items
      erb types.to_sym, {title: types.capitalize}
    end
  end
end
