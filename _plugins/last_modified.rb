# _plugins/last-modified.rb

module Jekyll
  class LastModifiedAt < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        post.data['last_modified_at'] = last_modified_at(post, site)
      end
    end

    private

    def last_modified_at(post, site)
      # Get the last modified time of the post file itself
      last_modified = File.mtime(post.path)

      # Get the last modified time of the include files used in the post
      post.content.scan(/{% include (.*?) %}/).each do |include_file|
        include_file_path = File.join(site.in_source_dir('_includes', include_file.first))
        if File.exist?(include_file_path)
          last_modified = [last_modified, File.mtime(include_file_path)].max
        end
      end

      # Return the last modified time formatted
      last_modified.strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end