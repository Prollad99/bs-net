module Jekyll
  class LastModifiedTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @file_name = text.strip
    end

    def render(context)
      site_source = context.registers[:site].source
      include_file = context[@file_name] || @file_name
      file_path = File.join(site_source, '_includes', include_file)

      if File.exist?(file_path)
        File.mtime(file_path).strftime("%Y-%m-%d %H:%M:%S")
      else
        "File not found: #{file_path}"
      end
    end
  end
end

Liquid::Template.register_tag('last_modified', Jekyll::LastModifiedTag)