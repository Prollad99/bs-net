module Jekyll
  class LastModifiedGenerator < Generator
    safe true
    priority :lowest

    def generate(site)
      site.posts.docs.each do |post|
        # Check if the post includes any files
        if post.content =~ /{% include .* %}/
          # Update the last modified date based on the include files
          include_files = Dir.glob("#{site.source}/_includes/**/*")
          latest_time = include_files.map { |file| File.mtime(file) }.max
          post.data['last_modified_at'] = latest_time
        end
      end
    end
  end
end