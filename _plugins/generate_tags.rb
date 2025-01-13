module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key?('tag')
        site.tags.each do |tag, posts|
          sanitized_tag = tag.gsub(' ', '-').downcase # Sanitize tag (lowercase, hyphens for spaces)
          site.pages << TagPage.new(site, site.source, "tag/#{sanitized_tag}/", tag)
        end
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir  = dir # Directory structure ensures trailing slash
      @name = 'index.html' # File is always index.html

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html') # Use tag.html as the layout
      self.data['tag'] = tag
      self.data['title'] = tag.split.map(&:capitalize).join(' ') # Capitalize tag for display
    end
  end
end