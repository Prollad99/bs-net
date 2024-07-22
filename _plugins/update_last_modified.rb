# Ensure the default external and internal encoding is set to UTF-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        # Get the modification time of the post file itself
        last_modified = File.mtime(post.path)

        # Check for any related files (e.g., images, data files)
        post_dir = File.dirname(post.path)
        Dir.glob("#{post_dir}/**/*").each do |file|
          next if file == post.path # Skip the post file itself
          next if File.directory?(file) # Skip directories

          # Update last_modified to the latest modification time found
          last_modified = [last_modified, File.mtime(file)].max
        end

        # Assign the last modified time to the post's data
        post.data['last_modified'] = last_modified

        # Debug output to verify last modified time is being set
        puts "Set last_modified for #{post.path} to #{last_modified}"
      end
    end
  end
end