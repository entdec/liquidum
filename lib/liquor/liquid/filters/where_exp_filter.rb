# frozen_string_literal: true

module WhereExpFilter
  # Filters an array of objects against an expression
  #
  # input - the object array
  # variable - the variable to assign each item to in the expression
  # expression - a Liquid comparison expression passed in as a string
  #
  # Returns the filtered array of objects
  def where_exp(input, variable, expression)
    return input unless input.respond_to?(:select)

    input = input.values if input.is_a?(Hash) # FIXME

    condition = parse_condition(expression)
    @context.stack do
      input.select do |object|
        @context[variable] = object
        condition.evaluate(@context)
      end
    end || []
  end

  private

  # Parse a string to a Liquid Condition
  def parse_condition(exp)
    parser    = Liquid::Parser.new(exp)
    condition = parse_binary_comparison(parser)

    parser.consume(:end_of_string)
    condition
  end

  # Generate a Liquid::Condition object from a Liquid::Parser object additionally processing
    # the parsed expression based on whether the expression consists of binary operations with
    # Liquid operators `and` or `or`
    #
    #  - parser: an instance of Liquid::Parser
    #
    # Returns an instance of Liquid::Condition
    def parse_binary_comparison(parser)
      parse_comparison(parser).tap do |condition|
        binary_operator = parser.id?("and") || parser.id?("or")
        condition.send(binary_operator, parse_comparison(parser)) if binary_operator
      end
    end

    # Generates a Liquid::Condition object from a Liquid::Parser object based on whether the parsed
    # expression involves a "comparison" operator (e.g. <, ==, >, !=, etc)
    #
    #  - parser: an instance of Liquid::Parser
    #
    # Returns an instance of Liquid::Condition
    def parse_comparison(parser)
      left_operand = Liquid::Expression.parse(parser.expression)
      operator     = parser.consume?(:comparison)

      # No comparison-operator detected. Initialize a Liquid::Condition using only left operand
      return Liquid::Condition.new(left_operand) unless operator

      # Parse what remained after extracting the left operand and the `:comparison` operator
      # and initialize a Liquid::Condition object using the operands and the comparison-operator
      Liquid::Condition.new(left_operand, operator, Liquid::Expression.parse(parser.expression))
    end

end

Liquid::Template.register_filter(WhereExpFilter)