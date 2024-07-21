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
        post.content.include?(File.basename(file)) && File.exist?(file)
      end

      latest_include_mtime = post_include_files.map { |file| File.mtime(file) }.max

      if latest_include_mtime && latest_include_mtime.to_date > post.date.to_date
        update_post_front_matter(post, latest_include_mtime)
      end
    end

    def update_post_front_matter(post, last_modified_at)
      post_path = post.path
      post_content = File.read(post_path, encoding: 'utf-8')

      # Extract front matter and content
      matches = post_content.match(/\A(---\s*\n.*?\n?)^(---\s*$\n?)(.*)/m)
      front_matter = matches[1]
      content = matches[3]

      # Update or add the last_modified_at field in the front matter
      formatted_last_modified_at = last_modified_at.strftime('%Y-%m-%d %H:%M:%S %z')

      if front_matter =~ /last_modified_at:/
        front_matter.gsub!(/last_modified_at: .*/, "last_modified_at: #{formatted_last_modified_at}")
      else
        front_matter = front_matter.chomp + "\nlast_modified_at: #{formatted_last_modified_at}\n"
      end

      # Write the updated content back to the file
      File.write(post_path, front_matter + "---\n" + content, encoding: 'utf-8')
    end
  end
end