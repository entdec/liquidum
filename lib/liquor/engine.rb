
module Liquor
  class Engine < ::Rails::Engine
    isolate_namespace Liquor

    config.autoload_paths << File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid'))

    initializer 'liquor.config' do |_app|
      path = File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid', '{tags,filters,drops}', '*.rb'))
      Dir.glob(path).each do |c|
        require_dependency(c)
      end
    end
  end
end
