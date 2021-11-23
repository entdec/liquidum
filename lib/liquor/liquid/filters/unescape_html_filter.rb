# frozen_string_literal: true

module UnescapeHTMLFilter
  # Unescape HTML tags.
  #
  # Example:
  #   <div class="summary">{{payload.test['MESSAGE']['STRING']['$'] | unescape_html}}</div>
  ##
  def unescape_html(input)
     CGI.unescapeHTML(input)
  end
end

Liquid::Template.register_filter(UnescapeHTMLFilter)
