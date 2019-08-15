# frozen_string_literal: true

# Add assets (by name) from the current Liquor site
#
# == Basic usage:
#    {%asset 'test.png'%}
#
# == Advanced usage:
#    {%asset 'test.png' height="72px"%}
#    {%asset 'test.png' style="height: 72px;"%}
#
# Note: It will only look at published assets
class AssetTag < LiquorTag
  include Rails.application.routes.url_helpers

  def render(context)
    super

    current_content = context.registers['content']

    content = current_content.site.contents.published.identified(argv1).first
    case content.content_type_group
    when 'image'
      path = content.path ? content.path : context.registers['controller'].helpers.scribo.content_path(content)
      %[<img] +
        attr_str(:src, arg(:src), path) +
        attr_str(:alt, content.title, content.name) +
        attr_str(:title, content.caption, content.name) +
        attr_str(:width, arg(:width)) +
        attr_str(:height, arg(:height)) +
        attr_str(:style, arg(:style)) +
        %[/>]
    when 'style'
      path = content.path ? content.path : context.registers['controller'].helpers.scribo.content_path(content)
      %[<link rel="stylesheet" type="text/css"] +
        attr_str(:href, arg(:href), path) +
        %[/>]
    end
  end
end

Liquid::Template.register_tag('asset', AssetTag)
