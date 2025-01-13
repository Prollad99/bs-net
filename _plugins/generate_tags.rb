module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key?('tag')
        site.tags.each do |tag, posts|
          # Sanitize the tag name for use in URLs
          sanitized_tag = tag.gsub(' ', '-').downcase
          dir = File.join('tag', sanitized_tag) # Directory path for the tag page

          # Ensure that the URL ends with a slash
          dir = "#{dir}/" unless dir.end_with?("/")

          # Generate a page for each tag
          site.pages << TagPage.new(site, site.source, dir, tag)
        end
      end
    end
  end

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir # This will create the directory with the tag name
      @name = 'index.html' # The name of the generated page

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = tag.split.map(&:capitalize).join(' ') # Capitalize the tag for the title
    end
  end
end