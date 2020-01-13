# frozen_string_literal: true

module SumFilter
  # Sums the items in the array
  #
  # input - the object array
  #
  # Returns the sum
  def sum(input)
    return input unless input.respond_to?(:sum)

    input = input.values if input.is_a?(Hash) # FIXME
    input.sum
  end
end
Liquid::Template.register_filter(SumFilter)
