module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      # Track which include files have been modified
      modified_includes = site.posts.docs.flat_map do |post|
        includes = post.content.scan(/\{% include (.*?) %\}/).map(&:first).map(&:strip)
        includes.select { |include_file| File.exist?(File.join(site.in_source_dir("_includes"), include_file)) && File.mtime(File.join(site.in_source_dir("_includes"), include_file)) > File.mtime(post.path) }
      end.uniq

      # Update last_modified for posts that include modified files
      site.posts.docs.each do |post|
        includes = post.content.scan(/\{% include (.*?) %\}/).map(&:first).map(&:strip)
        if (includes & modified_includes).any?
          last_modified = [File.mtime(post.path)] # Start with the post's own modification time

          includes.each do |include_file|
            include_path = File.join(site.in_source_dir("_includes"), include_file)
            if File.exist?(include_path)
              last_modified << File.mtime(include_path) # Add include file's modification time if it exists
            end
          end

          post.data['last_modified'] = last_modified.max # Set last_modified to the most recent date
        end

        # Debug output to verify last modified time is being set
        puts "Set last_modified for #{post.path} to #{post.data['last_modified']}"
      end
    end
  end
end