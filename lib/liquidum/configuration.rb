module Liquidum
  module Options
    module ClassMethods
      def option(name, default: nil)
        attr_accessor(name)

        schema[name] = default
      end

      def schema
        @schema ||= {}
      end
    end

    def set_defaults!
      self.class.schema.each do |name, default|
        instance_variable_set(:"@#{name}", default)
      end
    end

    def self.included(cls)
      cls.extend(ClassMethods)
    end
  end

  class Configuration
    include Options

    option :logger, default: -> { Logger.new($stdout).tap { |l| l.level = Logger::INFO } }
    option :liquidum_file_system, default: "Liquidum::LiquidumFileSystem"
    option :i18n_store, default: ->(context, block) {}

    def initialize
      set_defaults!
    end
  end

  module Configurable
    attr_writer :config

    def config
      @config ||= Configuration.new
    end

    def configure
      yield(config)
    end

    alias_method :setup, :configure

    def reset_config!
      @config = Configuration.new
    end
  end
end
