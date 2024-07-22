module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        begin
          includes = post.content.scan(/\{% include (.*?) %\}/).map(&:first).map(&:strip)
          
          last_modified = [File.mtime(post.path)]
          puts "Processing post: #{post.path}"
          puts "Post initial last_modified: #{last_modified.last}"

          includes.each do |include_file|
            include_path = File.join(site.source, '_includes', include_file)
            puts "Checking include file: #{include_path}"
            if File.exist?(include_path)
              include_mtime = File.mtime(include_path)
              last_modified << include_mtime
              puts "Include file: #{include_path} last_modified: #{include_mtime}"
            else
              puts "Include file not found: #{include_path}"
            end
          end

          post.data['last_modified'] = last_modified.max
          puts "Final last_modified for post: #{post.data['last_modified']}"
        rescue => e
          puts "Error processing post #{post.path}: #{e.message}"
        end
      end
    end
  end
end