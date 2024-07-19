# _plugins/generate_tags.rb
module Jekyll
  class TagPage < Page
    def initialize(site, base, dir, tag, formatted_tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['formatted_tag'] = formatted_tag
      self.data['title'] = "Posts tagged with '#{tag}'"
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        dir = 'tag'
        site.tags.each_key do |tag|
          formatted_tag = tag.downcase.gsub(' ', '-')
          write_tag_page(site, File.join(dir, formatted_tag), tag, formatted_tag)
        end
      end
    end

    def write_tag_page(site, dir, tag, formatted_tag)
      index = TagPage.new(site, site.source, dir, tag, formatted_tag)
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end
end