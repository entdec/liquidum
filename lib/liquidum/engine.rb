
module Liquidum
  class Engine < ::Rails::Engine
    isolate_namespace Liquidum

    config.autoload_paths << File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid'))

    initializer 'liquidum.config' do |_app|
      path = File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid', '{tags,filters,drops}', '*.rb'))
      Dir.glob(path).each do |c|
        require_dependency(c)
      end
    end

    # Its JavaScript (app/javascript/liquidum), pinned for an app with
    # importmap-rails; an app that bundles imports it from there
    initializer "liquidum.assets" do |app|
      app.config.assets.paths << root.join("app/javascript") if app.config.respond_to?(:assets)
    end

    initializer "liquidum.importmap", before: "importmap" do |app|
      if app.config.respond_to?(:importmap)
        app.config.importmap.paths << root.join("config/importmap.rb")
        app.config.importmap.cache_sweepers << root.join("app/javascript")
      end
    end
  end
end
