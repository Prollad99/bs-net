# Ensure the default external and internal encoding is set to UTF-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        # Initialize the last modified time with the post's file modification time
        last_modified = File.mtime(post.path)

        # Extract include files from the post content
        post.content.scan(/\{% include (.*?) %\}/).each do |include_file|
          include_path = File.join(site.in_source_dir("_includes"), include_file.first.strip)
          
          # Check if the include file exists and is a file
          if File.exist?(include_path) && File.file?(include_path)
            # Update the last_modified to the include file's modification time if it's newer
            last_modified = [last_modified, File.mtime(include_path)].max
          end
        end

        # Set the last modified date in the post's data
        post.data['last_modified'] = last_modified

        # Debug output to verify last modified time is being set
        puts "Set last_modified for #{post.path} to #{last_modified}"
      end
    end
  end
end