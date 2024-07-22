module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        includes = post.content.scan(/\{% include (.*?) %\}/).map(&:first).map(&:strip)
        last_modified = [File.mtime(post.path)] # Start with the post's own modification time

        puts "Post: #{post.path}"
        puts "Initial last_modified: #{last_modified.last}"

        includes.each do |include_file|
          include_path = File.join(site.in_source_dir("_includes"), include_file)
          if File.exist?(include_path)
            include_mtime = File.mtime(include_path)
            last_modified << include_mtime
            puts "Include: #{include_path}, last_modified: #{include_mtime}"
          else
            puts "Include file not found: #{include_path}"
          end
        end

        post.data['last_modified'] = last_modified.max # Set last_modified to the most recent date
        puts "Final last_modified for post: #{post.data['last_modified']}"
      end
    end
  end
end