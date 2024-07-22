# _plugins/custom_last_modified.rb

module Jekyll
  class CustomLastModifiedAt < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        last_modified = find_last_modified(post, site)

        if post.data['last_modified_at'].nil? || last_modified > Time.parse(post.data['last_modified_at'])
          post.data['last_modified_at'] = last_modified.strftime("%Y-%m-%d %H:%M:%S")
        end
      end
    end

    private

    def find_last_modified(post, site)
      last_modified = begin
        File.mtime(post.path)
      rescue StandardError => e
        Jekyll.logger.warn "Error reading mtime for #{post.path}: #{e}"
        Time.now # fallback to current time if file mtime cannot be read
      end

      post.content.scan(/{% include (.*?) %}/).each do |include_file|
        include_file_path = File.join(site.in_source_dir('_includes', include_file.first))
        if File.exist?(include_file_path)
          begin
            include_mtime = File.mtime(include_file_path)
            last_modified = [last_modified, include_mtime].max
          rescue StandardError => e
            Jekyll.logger.warn "Error reading mtime for include file #{include_file_path}: #{e}"
          end
        else
          Jekyll.logger.warn "Include file not found: #{include_file_path}"
        end
      end

      last_modified
    end
  end
end