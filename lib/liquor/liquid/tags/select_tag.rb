# frozen_string_literal: true

# Adds a (by default submit) button
#
# == Basic usage:
#    {%select name='group'%}{%endselect%}
#
# == Advanced usage:
#    {%select group%}{%endselect%}
#
class SelectTag < LiquorBlock
  def render(context)
    super

    result = %[<select] + attr_str(:name, arg(:name), input(:name, argv1)) +
      attr_str(:class, arg(:class)) +
      %[>] + render_body + %[</select>]

    # Errors for field
    main_form = context.scopes.select { |scope| scope.key? 'form' }.last
    if main_form
      error_messages = main_form['form'].errors.messages[path_for_input(argv1)]
      result += (error_messages || []).join(',')
    end

    result
  end
end

Liquid::Template.register_tag('select', SelectTag)
