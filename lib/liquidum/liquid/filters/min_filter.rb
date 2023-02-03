# frozen_string_literal: true

module MinFilter
  # Returns the min of the items in the array
  #
  # input - the object array
  #
  # Returns the min
  def min(input)
    return input unless input.respond_to?(:min)

    input = input.values if input.is_a?(Hash) # FIXME
    input.min
  end
end
Liquid::Template.register_filter(MinFilter)
