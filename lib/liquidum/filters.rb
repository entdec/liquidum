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
  # being the argument before), a date format ("format"), a translation's key
  # ("key"), or anything ("any"). `keeps` is "collection" (the same items),
  # "item" (one of them) or nil. Labels are liquidum.filters.<name>, in the
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
        description = DESCRIPTIONS.fetch(name, {arguments: [], keeps: nil})
        {
          name: name,
          label: I18n.t(name, scope: "liquidum.filters", default: name.humanize),
          arguments: description[:arguments].map { |argument, kind| {name: argument.to_s, kind: (kind || :any).to_s} },
          keeps: description[:keeps]&.to_s
        }.compact
      end
    end

    property = [:property, :property]
    value = [:value, :value]
    {
      # On collections
      "compact" => [[], :collection], "concat" => [[[:items]], :collection], "first" => [[], :item], "last" => [[], :item],
      "join" => [[[:separator]]], "map" => [[property]], "reverse" => [[], :collection], "size" => [[]],
      "sort" => [[property], :collection], "sort_natural" => [[property], :collection], "uniq" => [[], :collection],
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
      "date" => [[[:format, :format]]], "localize" => [[[:locale], [:format, :format]]], "strptime" => [[[:format, :format]]],
      "timezone" => [[[:zone]]], "to" => [[[:type]]]
    }.each { |name, (arguments, keeps)| describe(name, arguments: arguments, keeps: keeps) }
  end
end
