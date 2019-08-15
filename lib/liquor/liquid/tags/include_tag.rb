# frozen_string_literal: true

# Include other published content identified by name
#
# == Basic usage:
#    {%include 'navigation'}
#
# == Advanced usage:
#    {%include 'navigation' title="Menu"}
#
# This allows you pass variables to the included content, which will only available there
#
class IncludeTag < LiquorTag
  def render(context)
    super

    # TODO: How to make this work for both Scribo and Nuntius
    current_content = context.registers['content']
    content = current_content.site.contents.published.identified(argv1).first

    return unless content

    content&.render(context.environments.first.merge(attr_args.stringify_keys), context.registers)
  end
end

Liquid::Template.register_tag('include', IncludeTag)
