module Jekyll
  module RemoveLangPrefixFilter
    def remove_lang_prefix(url)
      languages = ['en', 'es', 'de'] # Add your language codes here
      pattern = %r{^/(#{languages.join('|')})/}
      url.sub(pattern, '/')
    end
  end
end

Liquid::Template.register_filter(Jekyll::RemoveLangPrefixFilter)