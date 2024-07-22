require 'jekyll'

module Jekyll
  class PostIncludeWatcher < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      includes_dir = File.join(site.source, '_includes')
      posts = site.posts.docs

      posts.each do |post|
        if post.content.match(/{%\s*include\s+['"]([^'"]+)['"]\s*%}/)
          included_files = post.content.scan(/{%\s*include\s+['"]([^'"]+)['"]\s*%}/).flatten

          included_files.each do |file|
            included_file_path = File.join(includes_dir, file)

            if File.exist?(included_file_path)
              post.data['last_modified_at'] = File.mtime(included_file_path)
            end
          end
        end
      end
    end
  end
end
