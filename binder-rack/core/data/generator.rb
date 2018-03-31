require "erb"
require "fileutils"

module BinderRack
  module Core
    class Generator
      def output_page(obj, file_name, template_dir, output_dir, options={}, extension="")
        template_path = "#{template_dir}/#{file_name}#{extension}.erb"
        output_path = "#{output_dir}/#{file_name}#{extension}"
        output(obj, template_path, output_path, options)
      end

      def output_pages(data_list, file_name, template_dir, output_dir, options={}, extension="")
        data_list.each do |key, obj|
          template_path = "#{template_dir}/#{file_name}#{extension}.erb"
          output_path = "#{output_dir}/#{file_name}/#{key}#{extension}"
          output(obj, template_path, output_path, options)
        end
      end

      def output(obj, template_path, output_path, options)
        @obj = obj
        @options = options
        contents = File.read(template_path)
        FileUtils.mkdir_p(File.dirname(output_path))
        File.write(output_path, ERB.new(contents).result(binding))
      end
    end
  end
end
