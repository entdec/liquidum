module Liquor
  class Engine < ::Rails::Engine
    isolate_namespace Liquor

    config.autoload_paths << File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid'))

    initializer 'scribo.config' do |_app|
      # if defined?(Liquid)
      path = File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid', '{tags,filters}', '*.rb'))
      Dir.glob(path).each do |c|
        require_dependency(c)
      end
      # end
    end
  end
end
