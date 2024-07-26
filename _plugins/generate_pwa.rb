module Jekyll
  class ManifestGenerator < Generator
    safe true

    def generate(site)
      site.posts.docs.each do |post|
        path = File.join(site.dest, post.url)
        FileUtils.mkdir_p(path) unless File.exist?(path)

        # Create manifest.json
        manifest = File.read(File.join(site.source, '_includes', 'manifest.json'))
        manifest_template = Liquid::Template.parse(manifest)
        manifest_content = manifest_template.render('post' => post.to_liquid)
        File.write(File.join(path, 'manifest.json'), manifest_content)

        # Create service-worker.js
        sw = File.read(File.join(site.source, '_includes', 'service-worker.js'))
        sw_template = Liquid::Template.parse(sw)
        sw_content = sw_template.render('post' => post.to_liquid)
        File.write(File.join(path, 'service-worker.js'), sw_content)
      end
    end
  end
end