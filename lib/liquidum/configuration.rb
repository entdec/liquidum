module Liquidum
  class Configuration
    attr_writer :logger
    attr_accessor :liquidum_file_system
    attr_writer :i18n_store

    def initialize
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @liquidum_file_system = 'Liquidum::LiquidumFileSystem'
      @i18n_store = ->(context, block) { nil }
    end

    # logger [Object].
    def logger
      @logger.is_a?(Proc) ? instance_exec(&@logger) : @logger
    end

    def i18n_store(context, &block)
      @i18n_store.is_a?(Proc) ? instance_exec(context, block, &@i18n_store) : @i18n_store
    end
  end
end
