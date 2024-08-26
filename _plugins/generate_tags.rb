module Jekyll
  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        # Combine tags from both _posts and _blogs directories
        tags = Hash.new { |hash, key| hash[key] = [] }
        
        # Collect tags from _posts
        site.posts.docs.each do |post|
          post.data['tags']&.each { |tag| tags[tag] << post }
        end

        # Collect tags from _blogs
        site.collections['blogs']&.docs&.each do |blog|
          blog.data['tags']&.each { |tag| tags[tag] << blog }
        end

        # Generate pages for each tag
        tags.each do |tag, posts|
          site.pages << TagPage.new(site, site.source, File.join('tag', tag), tag)
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