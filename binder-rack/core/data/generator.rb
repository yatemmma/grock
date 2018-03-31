require "erb"
require "fileutils"

module BinderRack
  module Core
    class Generator
      def output_list(obj, clazz, template_dir, output_dir, extension="")
        template_path = "#{template_dir}/#{clazz.id.pluralize}#{extension}.erb"
        output_path = "#{output_dir}/#{clazz.id.pluralize}#{extension}"
        output(obj, template_path, output_path)
      end

      def output_pages(data_list, clazz, template_dir, output_dir, extension="")
        data_list.each do |key, obj|
          template_path = "#{template_dir}/#{clazz.id}#{extension}.erb"
          output_path = "#{output_dir}/#{clazz.id}/#{key}#{extension}"
          output(obj, template_path, output_path, 1)
        end
      end

      def output(obj, template_path, output_path, dir_layer=0)
        @layer = dir_layer
        @obj = obj
        contents = File.read(template_path)
        FileUtils.mkdir_p(File.dirname(output_path))
        File.write(output_path, ERB.new(contents).result(binding))
      end
    end
  end
end
