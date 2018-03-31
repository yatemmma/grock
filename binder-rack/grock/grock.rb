require_relative "../core/data/reader"
require_relative "../core/data/generator"
require_relative "./models/models"

module GROCK
  class GROCK
    DATA_DIR = "#{File.dirname(__FILE__)}/../../data"
    DOCS_DIR = "#{File.dirname(__FILE__)}/../../docs"
    ADMIN_DIR = "#{File.dirname(__FILE__)}/../../docs_admin"
    TEMPLATE_DIR= "#{File.dirname(__FILE__)}/html"

    def read

      clazz = Label

      reader = BinderRack::Core::Reader.new
      data_list = reader.read_dir(DATA_DIR, clazz)

      p data_list

      generator = BinderRack::Core::Generator.new
      extension = ".html"

      generator.output_list(data_list, clazz, TEMPLATE_DIR, DOCS_DIR, extension)
      generator.output_pages(data_list, clazz, TEMPLATE_DIR, DOCS_DIR, extension)

    end


  end
end
