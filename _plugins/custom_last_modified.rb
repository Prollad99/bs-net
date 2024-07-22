# _plugins/custom_last_modified.rb

module Jekyll
  class CustomLastModifiedAt < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        # Update last modified date based on include files
        last_modified = find_last_modified(post, site)

        # Update post's last modified date if missing or if it should be updated
        if post.data['last_modified_at'].nil? || last_modified > Time.parse(post.data['last_modified_at'])
          post.data['last_modified_at'] = last_modified.strftime("%Y-%m-%d %H:%M:%S")
        end
      end
    end

    private

    def find_last_modified(post, site)
      last_modified = File.mtime(post.path)

      post.content.scan(/{% include (.*?) %}/).each do |include_file|
        include_file_path = File.join(site.in_source_dir('_includes', include_file.first))
        if File.exist?(include_file_path)
          last_modified = [last_modified, File.mtime(include_file_path)].max
        end
      end

      last_modified
    end
  end
end