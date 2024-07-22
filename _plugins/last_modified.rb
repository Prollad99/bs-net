module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        begin
          # Find include files in the post content
          includes = post.content.scan(/\{% include (.*?) %\}/).map(&:first).map(&:strip)
          
          # Start with the post's own modification time
          last_modified = [File.mtime(post.path)]
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

          # Set last_modified to the most recent date
          post.data['last_modified'] = last_modified.max
          puts "Final last_modified for post: #{post.data['last_modified']}"
        rescue => e
          puts "Error processing post #{post.path}: #{e.message}"
        end
      end
    end
  end
end