require_relative "../core/data/reader"
require_relative "../core/data/generator"
require_relative "./models/models"
require_relative "./html/helpers/helpers"

module GROCK
  class GROCK
    HASH_DATA_LIST = [Label, Member, Band]
    ARRAY_DATA_LIST = [Disc, Song]

    DATA_DIR = "#{File.dirname(__FILE__)}/../../data"
    DOCS_DIR = "#{File.dirname(__FILE__)}/../../docs"
    ADMIN_DIR = "#{File.dirname(__FILE__)}/../../docs_admin"
    TEMPLATE_DIR= "#{File.dirname(__FILE__)}/html"

    def read
      reader = BinderRack::Core::Reader.new

      data = HASH_DATA_LIST.inject({}) do |list, clazz|
        list[clazz] = reader.read_dir(DATA_DIR, clazz)
        list
      end
      ARRAY_DATA_LIST.inject(data) do |list, clazz|
        list[clazz] = reader.read_dir_items(DATA_DIR, clazz)
        list
      end
    end

    def gen_html
      data_list = read
      generator = BinderRack::Core::Generator.new
      extension = ".html"

      generator.output_page(data_list, "index", TEMPLATE_DIR, DOCS_DIR, {layer: 0}, extension)
      (HASH_DATA_LIST + ARRAY_DATA_LIST).each do |clazz|
        generator.output_page(data_list[clazz], clazz.id.pluralize, TEMPLATE_DIR, DOCS_DIR, {layer: 0}, extension)
        generator.output_pages(data_list[clazz], clazz.id, TEMPLATE_DIR, DOCS_DIR, {layer: 1}, extension)
      end
    end
  end
end
