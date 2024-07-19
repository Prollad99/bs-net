module Jekyll
  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "Posts tagged with \"#{tag}\""
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        dir = 'tag'
        site.tags.each_key do |tag|
          site.pages << TagPage.new(site, site.source, File.join(dir, tag.to_slug), tag)
        end
      end
    end
  end
end

class String
  def to_slug
    self.strip.downcase.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end