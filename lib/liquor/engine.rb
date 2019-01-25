module Liquor
  class Engine < ::Rails::Engine
    isolate_namespace Liquor

    config.autoload_paths << File.expand_path(File.join(File.dirname(__FILE__), '.', 'liquid'))

  end
end
