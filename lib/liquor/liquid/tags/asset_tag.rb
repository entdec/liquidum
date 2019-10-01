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

    content = current_content.site.contents.published.located(argv1).first
    content ||= current_content.site.contents.published.identified(argv1).first

    full_path = content.full_path
    if File.basename(full_path).starts_with?('_')
      full_path = context.registers['controller'].helpers.scribo.content_path(content)
    end

    case content&.content_type_group
    when 'image'
      %[<img] +
        attr_str(:src, arg(:src), full_path) +
        attr_str(:alt, content.title, content.title) +
        attr_str(:title, content.caption, content.caption) +
        attr_str(:width, arg(:width)) +
        attr_str(:height, arg(:height)) +
        attr_str(:style, arg(:style)) +
        %[/>]
    when 'style'
      %[<link rel="stylesheet" type="text/css"] +
        attr_str(:href, arg(:href), full_path) +
        %[/>]
    when 'script'
      %[<script] +
        attr_str(:src, arg(:src), full_path) +
        %[/></script>]
    else
      "<!-- unknown asset: #{argv1} -->"
    end
  end
end

Liquid::Template.register_tag('asset', AssetTag)
