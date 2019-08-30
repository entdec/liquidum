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
  #
  def to(input, format, options={})
    case format
    when 'yaml'
      YAML.dump(input)
    when 'json'
      if options['pretty']
        JSON.pretty_generate(input)
      else
        input.to_json
      end
    else
      raise "No to format given"
    end
  end
end

Liquid::Template.register_filter(ToFilter)
