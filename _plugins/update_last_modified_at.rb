require 'jekyll'
require 'fileutils'

module Jekyll
  class UpdateLastModifiedAt < Generator
    priority :low

    def generate(site)
      site.posts.docs.each do |post|
        file_path = post.path
        last_modified_time = File.mtime(file_path)

        if post.data['last_modified_at'].nil? || post.data['last_modified_at'] != last_modified_time
          post.data['last_modified_at'] = last_modified_time

          # Update the front matter of the post
          content = File.read(file_path)
          new_content = content.sub(
            /last_modified_at: .*/,
            "last_modified_at: #{last_modified_time}"
          )

          File.write(file_path, new_content)
        end
      end
    end
  end
end
