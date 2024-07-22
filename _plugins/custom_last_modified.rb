# _plugins/custom_last_modified.rb
module Jekyll
  class CustomLastModifiedAt < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      Jekyll.logger.info "CustomLastModifiedAt:", "Running custom last modified plugin."
      site.posts.docs.each do |post|
        last_modified = find_last_modified(post, site)

        if post.data['last_modified_at'].nil? || last_modified > Time.parse(post.data['last_modified_at'])
          post.data['last_modified_at'] = last_modified.strftime("%Y-%m-%d %H:%M:%S")
        end
      end
    end

    private

    def find_last_modified(post, site)
      Jekyll.logger.info "CustomLastModifiedAt:", "Finding last modified date for #{post.path}."
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