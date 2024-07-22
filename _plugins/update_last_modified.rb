require 'jekyll'
require 'yaml'
require 'time'

module Jekyll
  class LastModifiedGenerator < Generator
    safe true

    def generate(site)
      posts_dir = '_posts'
      Dir.glob("#{posts_dir}/*").each do |file|
        # Read the file content
        content = File.read(file)

        # Extract the front matter
        if content =~ /\A---\s*\n(.*?\n?)^---\s*$\n?(.*)/m
          front_matter = Regexp.last_match(1)
          body_content = Regexp.last_match(2)

          # Parse the front matter YAML
          data = YAML.load(front_matter)

          # Get the last modified time of the file
          last_modified_time = File.mtime(file).utc

          # Update the last_modified_at field
          data['last_modified_at'] = last_modified_time.iso8601

          # Reconstruct the file content
          new_front_matter = data.to_yaml
          new_content = "---\n#{new_front_matter}---\n#{body_content}"

          # Write the updated content back to the file
          File.open(file, 'w') { |f| f.write(new_content) }

          Jekyll.logger.info "Updated last_modified_at in #{file}: #{last_modified_time}"
        else
          Jekyll.logger.warn "No front matter found in #{file}, skipping..."
        end
      end
    end
  end
end