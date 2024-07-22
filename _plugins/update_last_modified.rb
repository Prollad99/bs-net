# Ensure the default external and internal encoding is set to UTF-8
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

module Jekyll
  class LastModifiedGenerator < Generator
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        # Read the content of the file with UTF-8 encoding
        content = File.read(post.path, encoding: 'UTF-8')

        # Get the last modified time of the file
        last_modified = File.mtime(post.path)

        # Assign the last modified time to the post's data
        post.data['last_modified'] = last_modified
      end
    end
  end
end