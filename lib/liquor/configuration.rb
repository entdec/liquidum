module Liquor
  class Configuration
    attr_writer :logger
    attr_accessor :liquor_file_system

    def initialize
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @liquor_file_system = 'Liquor::LiquorFileSystem'
    end

    # logger [Object].
    def logger
      @logger.is_a?(Proc) ? instance_exec(&@logger) : @logger
    end
  end
end
