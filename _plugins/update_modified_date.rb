require 'fileutils'

module Jekyll
  class UpdateModifiedDate < Generator
    priority :lowest

    def generate(site)
      site.posts.docs.each do |post|
        update_post_modified_date(post, site.source)
      end
    end

    private

    def update_post_modified_date(post, source)
      includes_dir = File.join(source, '_includes')
      includes_files = Dir.glob("#{includes_dir}/**/*")

      post_include_files = includes_files.select do |file|
        post.content.include?(File.basename(file))
      end

      latest_include_mtime = post_include_files.map { |file| File.mtime(file) }.max

      if latest_include_mtime && latest_include_mtime > post.date
        update_post_front_matter(post, latest_include_mtime)
      end
    end

    def update_post_front_matter(post, last_modified_at)
      post_path = post.path
      post_content = File.read(post_path)

      # Extract front matter and content
      front_matter, content = post_content.match(/\A(---\s*\n.*?\n?)^(---\s*$\n?)(.*)/m).captures

      # Update or add the last_modified_at field in the front matter
      if front_matter =~ /last_modified_at:/
        front_matter.gsub!(/last_modified_at: .*/, "last_modified_at: #{last_modified_at.strftime('%Y-%m-%d %H:%M:%S %z')}")
      else
        front_matter << "last_modified_at: #{last_modified_at.strftime('%Y-%m-%d %H:%M:%S %z')}\n"
      end

      # Write the updated content back to the file
      File.write(post_path, front_matter + "---\n" + content)
    end
  end
end