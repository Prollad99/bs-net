module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      modified_includes = site.posts.docs.flat_map do |post|
        includes = post.content.scan(/\{% include (.*?) %\}/).map(&:first).map(&:strip)
        includes.select do |include_file|
          include_path = File.join(site.in_source_dir("_includes"), include_file)
          File.exist?(include_path) && File.mtime(include_path) > File.mtime(post.path)
        end
      end.uniq

      site.posts.docs.each do |post|
        includes = post.content.scan(/\{% include (.*?) %\}/).map(&:first).map(&:strip)
        if (includes & modified_includes).any?
          last_modified = [File.mtime(post.path)] # Initialize with the post's own modification time

          includes.each do |include_file|
            include_path = File.join(site.in_source_dir("_includes"), include_file)
            last_modified << File.mtime(include_path) if File.exist?(include_path)
          end

          post.data['last_modified'] = last_modified.max # Update last_modified to the most recent date
        end

        # Debug output
        puts "Set last_modified for #{post.path} to #{post.data['last_modified']}"
      end
    end
  end
end