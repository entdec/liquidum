# frozen_string_literal: true

# Add a text-field, either specifying everything manually or using a model object on the form
#
# == Basic usage:
#    {%number_field name="name" value="Pencil"%}
#
# == Advanced usage:
#    {%number_field name%}
#
# This last usage requires a model on the form
#

require_relative './number_field_tag'

class NumberFieldTag < TextFieldTag
  def initialize(tag, args, tokens)
    super
    @field_type = 'number'
  end
end

Liquid::Template.register_tag('number_field', NumberFieldTag)
