module Liquor
  class Configuration
    attr_writer :logger
    attr_writer :translation_scope

    def initialize
      @logger = Logger.new(STDOUT)
      @logger.level = Logger::INFO
      @translation_scope = ->(_context) {}
    end

    # logger [Object].
    def logger
      @logger.is_a?(Proc) ? instance_exec(&@logger) : @logger
    end

    def translation_scope(context)
      raise 'translation_scope should be a Proc' unless @translation_scope.is_a? Proc
      instance_exec(context, &@translation_scope)
    end
  end
end
