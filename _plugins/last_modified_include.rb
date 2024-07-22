# _plugins/last_modified_include.rb
require 'jekyll'

module Jekyll
  class LastModifiedInclude < Generator
    priority :highest

    def generate(site)
      site.posts.docs.each do |post|
        # Get the include file specified in the front matter
        include_file = post.data['include_file']
        next unless include_file

        # Compute the full path to the include file
        include_path = File.join(site.source, '_includes', include_file)

        # Check if the file exists and get its last modified time
        if File.exist?(include_path)
          last_modified_time = File.mtime(include_path)
          post.data['include_last_modified'] = last_modified_time
        else
          post.data['include_last_modified'] = nil
        end
      end
    end
  end
end