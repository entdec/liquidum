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
class TextFieldTag < LiquorTag
  attr_accessor :field_type

  def initialize(tag, args, tokens)
    super
    @field_type = 'text'
  end

  def render(context)
    super

    result = %[<input] + attr_str(:name, arg(:name), input(:name, argv1)) +
             attr_str(:id, arg(:id), input(:id, argv1)) +
             attr_str(:value, arg(:value), input(:value, argv1)) +
             attrs_str(:disabled, :maxlength, :placeholder) + %[ type="#{field_type}"/>]

    # Errors for field
    # main_form = @context.scopes.select { |scope| scope.key? 'form' }.last
    # if main_form
    #   error_messages = main_form['form'].errors.messages[path_for_input(argv1)]
    #   result += (error_messages || []).join(',')
    # end
    error_messages = context["form.errors.messages.#{argv1}"]
    result += (error_messages || []).join(',')

    result
  end
end

Liquid::Template.register_tag('text_field', TextFieldTag)
