# frozen_string_literal: true

# Add a text-field, either specifying everything manually or using a model object on the form
#
# == Basic usage:
#    {%text_field name="name" value="Pencil"%}
#
# == Advanced usage:
#    {%text_field name%}
#
# This last usage requires a model on the form
#
class OptionsForSelectTag < LiquorTag
  def render(context)
    super

    context.registers['controller'].helpers.options_for_select(argv1).to_s
  end
end

Liquid::Template.register_tag('options_for_select', OptionsForSelectTag)
