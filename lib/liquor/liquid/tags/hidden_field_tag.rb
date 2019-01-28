# frozen_string_literal: true

# Add a text-field, either specifying everything manually or using a model object on the form
#
# == Basic usage:
#    {%hidden_field name="name" value="Pencil"%}
#
# == Advanced usage:
#    {%hidden_field name%}
#
# This last usage requires a model on the form
#
class HiddenFieldTag < LiquorTag
  def render(context)
    super

    result = %[<input] + attr_str(:name, arg(:name), input(:name, argv1)) +
             attr_str(:id, arg(:id), input(:id, argv1)) +
             attr_str(:value, arg(:value), input(:value, argv1)) +
             attrs_str(:disabled) + %[ type="hidden"/>]

    result
  end
end

Liquid::Template.register_tag('hidden_field', HiddenFieldTag)
