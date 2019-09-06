# frozen_string_literal: true

# Add a text-field, either specifying everything manually or using a model object on the form
#
# == Basic usage:
#    {%hidden_field name:"name" value:"Pencil"%}
#
# == Advanced usage:
#    {%hidden_field name%}
#
# This last usage requires a model on the form
#
class HiddenFieldTag < TextFieldTag
  def initialize(tag, args, tokens)
    super
    @field_type = 'hidden'
  end
end

Liquid::Template.register_tag('hidden_field', HiddenFieldTag)
