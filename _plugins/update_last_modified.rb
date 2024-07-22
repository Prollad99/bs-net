module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        includes = post.content.scan(/\{% include (.*?) %\}/).map(&:first).map(&:strip)
        last_modified = [File.mtime(post.path)] # Start with the post's own modification time

        includes.each do |include_file|
          include_path = File.join(site.in_source_dir("_includes"), include_file)
          if File.exist?(include_path)
            last_modified << File.mtime(include_path)
          end
        end

        post.data['last_modified'] = last_modified.max # Set last_modified to the most recent date
      end
    end
  end
end