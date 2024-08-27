module Jekyll
  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'category'
        language_dirs = site.config['languages'] || []

        site.categories.each do |category, posts|
          next if language_dirs.include?(category)

          site.pages << CategoryPage.new(site, site.source, category)
        end
      end
    end
  end

  class CategoryPage < Page
    def initialize(site, base, category)
      @site = site
      @base = base
      @dir  = category  # Root-level category pages
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category.html')
      self.data['category'] = category

      formatted_category = category.split('-').map(&:capitalize).join(' ')
      self.data['title'] = "#{formatted_category}: What You Need to Know"
    end
  end
end