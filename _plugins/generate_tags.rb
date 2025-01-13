module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key?('tag')
        site.tags.each do |tag, posts|
          sanitized_tag = tag.gsub(' ', '-').downcase # Sanitize tag
          dir = File.join('tag', sanitized_tag) # Enforce directory structure
          site.pages << TagPage.new(site, site.source, dir, tag)
        end
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = "#{dir}/" # Ensure trailing slash for directories
      @name = 'index.html' # File name is always index.html

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = tag.split.map(&:capitalize).join(' ')
    end
  end
end