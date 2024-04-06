module Liquidum
  module Options
    module ClassMethods
      def option(name, default: nil, proc: false)
        attr_writer(name)
        schema[name] = {default: default, proc: proc}

        if schema[name][:proc]
          define_method(name) do |*params|
            value = instance_variable_get(:"@#{name}")
            instance_exec(*params, &value)
          end
        else
          define_method(name) do
            instance_variable_get(:"@#{name}")
          end
        end
      end

      def schema
        @schema ||= {}
      end
    end

    def set_defaults!
      self.class.schema.each do |name, options|
        instance_variable_set(:"@#{name}", options[:default])
      end
    end

    def self.included(cls)
      cls.extend(ClassMethods)
    end
  end

  class Configuration
    include Options

    option :logger, default: -> { Logger.new($stdout).tap { |l| l.level = Logger::INFO } }, proc: true
    option :liquidum_file_system, default: "Liquidum::LiquidumFileSystem"
    attr_writer :i18n_store

    def initialize
      @i18n_store = ->(context, block) {}
      set_defaults!
    end

    def i18n_store(context, &block)
      old_i18n_backend = I18n.backend
      I18n.backend = instance_exec(context, &@i18n_store)
      yield
    ensure
      I18n.backend = old_i18n_backend
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
