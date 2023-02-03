# frozen_string_literal: true

module MaxFilter
  # Returns the max of the items in the array
  #
  # input - the object array
  #
  # Returns the max
  def max(input)
    return input unless input.respond_to?(:max)

    input = input.values if input.is_a?(Hash) # FIXME
    input.max
  end
end
Liquid::Template.register_filter(MaxFilter)
