
module Liquor
  class Engine < ::Rails::Engine
    isolate_namespace Liquor

    config.autoload_paths << File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid'))

    initializer 'scribo.config' do |_app|
      I18n.backend = I18n::Backend::Chain.new(Scribo::BucketI18nBackend.new, I18n.backend)
      path = File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid', '{tags,filters}', '*.rb'))
      Dir.glob(path).each do |c|
        require_dependency(c)
      end
    end
  end
end
