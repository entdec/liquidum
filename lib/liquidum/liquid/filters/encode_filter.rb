# frozen_string_literal: true

module EncodeFilter
  # Encode text
  #
  # Example:
  #   <div class="summary">{{title | encode: 'utf-8'}}</div>
  ##
  def encode(input, encoding, options = {})
    input.encode(encoding)
  end
end

Liquid::Template.register_filter(EncodeFilter)
