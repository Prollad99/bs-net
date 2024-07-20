module Jekyll
  class Post
    def update_last_modified_at
      # Get the modification time of the post file
      post_mod_time = File.mtime(self.path)

      # Get the include files referenced in the content
      includes = self.content.scan(/{% include (.+?) %}/).flatten

      # Get the modification times of the include files
      include_file_mod_times = includes.map do |include_file|
        include_path = File.join(@site.in_source_dir("_includes", include_file))
        File.mtime(include_path) if File.exist?(include_path)
      end

      # Combine post and include file modification times
      all_mod_times = include_file_mod_times.compact << post_mod_time

      # Update last_modified_at to the latest modification time
      latest_mod_time = all_mod_times.max
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