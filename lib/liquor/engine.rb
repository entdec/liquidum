
module Liquor
  class Engine < ::Rails::Engine
    isolate_namespace Liquor

    config.autoload_paths << File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid'))

    initializer 'liquor.config' do |_app|
      # FIXME: How to make this work with Scribo and Nuntius
      I18n.backend = I18n::Backend::Chain.new(Scribo::BucketI18nBackend.new, I18n.backend) if defined? I18n::HashRefinements
      path = File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid', '{tags,filters}', '*.rb'))
      Dir.glob(path).each do |c|
        require_dependency(c)
      end
    end
  end
end
