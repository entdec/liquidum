# frozen_string_literal: true

module Liquor
  class Tag
    require 'parslet'

    class MiniP < Parslet::Parser
      # Single character rules
      rule(:squote) { str("'").repeat(1) }
      rule(:dquote) { str('"').repeat(1) }

      rule(:colon_or_eql) { match[":|="].repeat(1) }

      rule(:space) { match('\s').repeat(1) }
      rule(:space?) { space.maybe }

      # Things
      rule(:identifier) { (match('[a-zA-Z]') >> match('[a-zA-Z0-9\.\/\_\-\[\]\'\"]').repeat) }
      rule(:symbol_literal) { colon_or_eql >> identifier.as(:svalue) }

      rule(:nsqvalue) { match["^'"] }
      rule(:ndqvalue) { match['^"'] }

      rule(:literal_value) { identifier >> colon_or_eql >> identifier }

      rule(:squoted_value) { squote >> nsqvalue.repeat.as(:value) >> squote }
      rule(:dquoted_value) { dquote >> ndqvalue.repeat.as(:value) >> dquote }
      rule(:quoted_value) { squoted_value | dquoted_value }

      rule(:standalone_squoted_value) { squote >> nsqvalue.repeat.as(:quoted) >> squote }
      rule(:standalone_dquoted_value) { dquote >> ndqvalue.repeat.as(:quoted) >> dquote }
      rule(:standalone_quoted_value) { standalone_squoted_value | standalone_dquoted_value }

      # Grammar parts
      rule(:standalone) { identifier.as(:literal) >> space? }
      rule(:quoted) { standalone_quoted_value >> space? }
      rule(:attr_with_literal) { identifier.as(:attr) >> space? >> colon_or_eql >> space? >> identifier.as(:lvalue) >> space? }
      rule(:attr_with_quoted) { identifier.as(:attr) >> space? >> colon_or_eql >> space? >> quoted_value >> space? }

      rule(:attribute) { attr_with_quoted | attr_with_literal | quoted | standalone }
      rule(:expression) { attribute.repeat }
      root :expression
    end

    class Parser
      attr_reader :args

      def initialize(raw)
        @args = MiniP.new.parse(raw)
      end
    end
  end
end
