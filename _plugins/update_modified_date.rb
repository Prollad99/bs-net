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
        post.data['last_modified_at'] = latest_include_mtime
      end
    end
  end
end