# frozen_string_literal: true

module ToFilter
  # Turn object in something else
  #
  # Example:
  #   {{message.payload | to: 'json'}}
  #   {{message.payload | to: 'yaml'}}
  #
  # Advanced example:
  #   {{payload | to: 'json', pretty: true}}
  #   {%assign today = 'now'|to: 'date'%}
  #
  def to(input, format, options = {})
    case format
    when 'yaml'
      to_dump = input
      to_dump = to_dump.to_h if input.is_a?(HashWithIndifferentAccess)
      result  = YAML.dump(to_dump)
      result  = result.gsub(/^---\n/, '') if options['inline']
      result
    when 'json'
      if options['pretty']
        JSON.pretty_generate(input)
      else
        input.to_json
      end
    when 'date'
      date = Liquid::Utils.to_date(input)

      return input if date.to_s.empty?
      return date if options[:format].to_s.empty?

      date.strftime(options[:format].to_s)
    else
      raise 'No to format given'
    end
  end
end

Liquid::Template.register_filter(ToFilter)
