module Jekyll
  class ManifestGenerator < Generator
    safe true

    def generate(site)
      site.posts.docs.each do |post|
        path = File.join(site.dest, post.url)
        FileUtils.mkdir_p(path) unless File.exist?(path)
        
        # Create manifest.json
        manifest = File.read(File.join(site.source, '_includes', 'manifest.json'))
        File.write(File.join(path, 'manifest.json'), post.render_liquid(manifest))

        # Create service-worker.js
        sw = File.read(File.join(site.source, '_includes', 'service-worker.js'))
        File.write(File.join(path, 'service-worker.js'), post.render_liquid(sw))
      end
    end
  end
end