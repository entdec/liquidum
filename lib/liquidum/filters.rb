# frozen_string_literal: true

module Liquidum
  # The filters a template can use, for an editor's completion after a |:
  # those Liquid has registered (its own, Liquidum's and the host's), each
  # with what it's for and its arguments, and what a filter on a collection
  # leaves (`keeps`), so an editor knows `lines | where: "party", "sponsor"`
  # is still a collection of lines.
  #
  #   Liquidum::Filters.all
  #   # => [{name: "where", label: "Those whose property has the value",
  #   #      arguments: [{name: "property", kind: "property"}, {name: "value", kind: "value"}],
  #   #      keeps: "collection"}, …]
  #
  # An argument's kind says what goes there: a property of the collection's
  # items ("property"), a value a property can have ("value", the property
  # being the argument before), a date format ("format", strftime's, with the
  # app's date.formats and time.formats as its `values`), a
  # translation's key ("key"), a locale ("locale", with the app's locales as
  # its `values`), or anything ("any"). `optional` says whether it can be left
  # out, from the filter's method (truncate: 20 or truncate: 20, "…"), when its
  # method says. `keeps` is "collection" (the same items), "item" (one of
  # them), "property" (a list of the property its first argument names, as
  # map gives) or nil. An undescribed filter has its method's arguments. Labels are liquidum.filters.<name>, in the
  # current locale; a host describes its own filters the same way:
  #
  #   Liquidum::Filters.describe :money, arguments: [], keeps: nil
  #
  # and labels them in its locale files.
  module Filters
    DESCRIPTIONS = {}

    module_function

    def describe(name, arguments: [], keeps: nil)
      DESCRIPTIONS[name.to_s] = {arguments: arguments.map { |argument| Array(argument) }, keeps: keeps}
    end

    def all
      names = Liquid::Environment.default.strainer_template.filter_method_names.map(&:to_s).sort
      names.map do |name|
        description = DESCRIPTIONS[name]
        parameters = parameters(name)
        # Undescribed, its arguments are its method's, of any kind
        arguments = description ? description[:arguments] : Array(parameters).map { |_, parameter| [parameter] }
        {
          name: name,
          label: I18n.t(name, scope: "liquidum.filters", default: name.humanize),
          arguments: arguments.each_with_index.map { |(argument, kind), index| argument(argument, kind || :any, parameters && parameters[index]) },
          keeps: description&.dig(:keeps)&.to_s
        }.compact
      end
    end

    # A filter method's positional arguments after its input, [kind, name]
    # with kind :req or :opt; named ones (t: name: …, an options hash) aren't.
    # nil when it takes any number (*args) or isn't a method
    def parameters(name)
      parameters = Liquid::Environment.default.strainer_template.instance_method(name).parameters.drop(1)
      return nil if parameters.any? { |kind, _| kind == :rest }

      parameters.select { |kind, parameter| %i[req opt].include?(kind) && parameter != :options }
    rescue NameError
      nil
    end

    # `optional` from its method's parameter at its place, when known
    def argument(name, kind, parameter = nil)
      values = case kind
      when :locale then I18n.available_locales.map { |locale| {value: locale.to_s, label: locale.to_s} }
      when :format then formats
      end
      optional = parameter ? parameter.first == :opt : nil
      {name: name.to_s, kind: kind.to_s, values: values, optional: optional}.compact
    end

    # The app's own date and time formats (date.formats, time.formats in the
    # current locale), strftime's patterns as date and localize take them,
    # each once, labelled with its name
    def formats
      %w[date time].flat_map do |type|
        patterns = I18n.t("#{type}.formats", default: {})
        next [] unless patterns.is_a?(Hash)

        patterns.filter_map do |format, pattern|
          next unless pattern.is_a?(String)

          {value: pattern, label: I18n.t(type, scope: "liquidum.formats", name: format, default: "#{type} #{format}")}
        end
      end.uniq { |format| format[:value] }
    end

    property = [:property, :property]
    value = [:value, :value]
    {
      # On collections
      "compact" => [[property], :collection], "concat" => [[[:items]], :collection], "first" => [[], :item], "last" => [[], :item],
      "join" => [[[:separator]]], "map" => [[property], :property], "reverse" => [[], :collection], "size" => [[]],
      "sort" => [[property], :collection], "sort_natural" => [[property], :collection], "uniq" => [[property], :collection],
      "where" => [[property, value], :collection], "reject" => [[property, value], :collection],
      "where_exp" => [[[:item], [:condition]], :collection], "find" => [[property, value], :item],
      "find_index" => [[property, value]], "has" => [[property, value]], "sum" => [[]], "min" => [[]], "max" => [[]],
      "array_wrap" => [[], :collection],
      # Text
      "append" => [[[:text]]], "prepend" => [[[:text]]], "capitalize" => [[]], "downcase" => [[]], "upcase" => [[]],
      "default" => [[[:value]]], "escape" => [[]], "escape_once" => [[]], "h" => [[]], "strip" => [[]], "lstrip" => [[]],
      "rstrip" => [[]], "squish" => [[]], "strip_html" => [[]], "strip_newlines" => [[]], "newline_to_br" => [[]],
      "remove" => [[[:text]]], "remove_first" => [[[:text]]], "remove_last" => [[[:text]]],
      "replace" => [[[:text], [:replacement]]], "replace_first" => [[[:text], [:replacement]]], "replace_last" => [[[:text], [:replacement]]],
      "slice" => [[[:start], [:length]]], "split" => [[[:separator]]], "truncate" => [[[:length], [:ellipsis]]],
      "truncatewords" => [[[:words], [:ellipsis]]], "url_encode" => [[]], "url_decode" => [[]], "base64_encode" => [[]],
      "base64_decode" => [[]], "base64_url_safe_encode" => [[]], "base64_url_safe_decode" => [[]],
      "unescape_html" => [[]], "encode" => [[[:encoding]]], "format" => [[[:format]]],
      "t" => [[[:key, :key]]], "translate" => [[[:key, :key]]],
      # Numbers
      "abs" => [[]], "ceil" => [[]], "floor" => [[]], "round" => [[[:decimals]]], "plus" => [[[:number]]],
      "minus" => [[[:number]]], "times" => [[[:number]]], "divided_by" => [[[:number]]], "modulo" => [[[:number]]],
      "at_least" => [[[:number]]], "at_most" => [[[:number]]],
      # Dates
      "date" => [[[:format, :format]]], "localize" => [[[:locale, :locale], [:format, :format]]], "strptime" => [[[:format, :format]]],
      "timezone" => [[[:zone]]], "to" => [[[:type]]]
    }.each { |name, (arguments, keeps)| describe(name, arguments: arguments, keeps: keeps) }
  end
end
