# _plugins/update_last_modified.rb
module Jekyll
  class Post
    def update_last_modified_at
      # Get the include files referenced in the content
      includes = self.content.scan(/{% include (.+?) %}/).flatten
      
      # Get the modification times of the include files
      include_file_mod_times = includes.map do |include_file|
        include_path = File.join(@site.in_source_dir("_includes", include_file))
        File.mtime(include_path) if File.exist?(include_path)
      end

      # Update last_modified_at to the latest include file modification time
      latest_mod_time = include_file_mod_times.compact.max
      self.data['last_modified_at'] = latest_mod_time if latest_mod_time
    end
  end

  class PostCollection
    def initialize(site)
      @site = site
      @posts = []
      @site.posts.docs.each do |post|
        post.update_last_modified_at
        @posts << post
      end
    end
  end
end