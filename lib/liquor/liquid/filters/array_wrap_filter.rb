# frozen_string_literal: true

module ArraywrapFilter
  # Wraps an object into an array if it is not already an array.
  #
  # Example:
  #   <div class="summary">{%assign res = payload.test['MESSAGE']['ITEM'] | array_wrap %}{%for item in res %}{{item['PN']['$']}}{%endfor%}</div>
  ##
  def array_wrap(input)
     Array.wrap(input)
  end
end

Liquid::Template.register_filter(ArraywrapFilter)
