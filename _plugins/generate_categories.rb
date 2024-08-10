module Jekyll
  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'category'
        site.categories.each do |category, posts|
          # Normalize category name to slug format for the URL
          slug = category.downcase.gsub(/\s+/, '-')
          # Generate a page for each category
          site.pages << CategoryPage.new(site, site.source, slug, category)
        end
      end
    end
  end

  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir  = dir  # This is the directory where the category page will reside
      @name = 'index.html'  # Each category will have its own index.html

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category.html')
      self.data['category'] = category
      self.data['title'] = "Posts in #{category.capitalize}"
    end
  end
end