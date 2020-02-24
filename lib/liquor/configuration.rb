module Liquor
  class Configuration
    attr_writer :logger
    attr_accessor :liquor_file_system
    attr_writer :i18n_store

    def initialize
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @liquor_file_system = 'Liquor::LiquorFileSystem'
      @i18n_store = ->(context) { nil }
    end

    # logger [Object].
    def logger
      @logger.is_a?(Proc) ? instance_exec(&@logger) : @logger
    end

    def i18n_store(context)
      @i18n_store.is_a?(Proc) ? instance_exec(&@i18n_store) : @i18n_store
    end
  end
end
