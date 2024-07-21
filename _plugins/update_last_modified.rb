module Jekyll
  module LastModified
    def update_last_modified_at
      post_mod_time = File.mtime(self.path)

      includes = self.content.scan(/{% include (.+?) %}/).flatten

      include_file_mod_times = includes.map do |include_file|
        include_path = @site.in_source_dir("_includes", include_file)
        File.exist?(include_path) ? File.mtime(include_path) : nil
      end

      all_mod_times = include_file_mod_times.compact << post_mod_time
      latest_mod_time = all_mod_times.max

      self.data['last_modified_at'] = latest_mod_time if latest_mod_time && latest_mod_time != self.data['last_modified_at']
    end
  end

  Hooks.register :documents, :pre_render do |document|
    if document.is_a?(Jekyll::Document) && document.collection.label == "posts"
      document.extend LastModified
      document.update_last_modified_at
    end
  end
end