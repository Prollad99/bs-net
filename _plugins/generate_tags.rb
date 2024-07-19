module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        site.tags.each do |tag, posts|
          # Convert tag to lowercase and replace spaces with hyphens
          formatted_tag = tag.downcase.gsub(' ', '-')
          site.pages << TagPage.new(site, site.source, File.join('tag', formatted_tag), tag)
        end
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "Posts Tagged with \"#{tag}\""
    end
  end
end