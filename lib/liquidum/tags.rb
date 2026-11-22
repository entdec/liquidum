# frozen_string_literal: true

module Liquidum
  # The tags a template can use, for an editor's completion after {%: those
  # Liquid has registered (its own, Liquidum's and the host's), each with how
  # it's written and whether it's a block, which the editor writes with its
  # closing tag ({% if … %}{% endif %}).
  #
  #   Liquidum::Tags.all
  #   # => [{name: "if", label: "Only when a condition holds", syntax: "if condition", block: true}, …]
  #
  # The tags inside a block (elsif, else, when) are Liquid's syntax, which the
  # editor knows. Labels are liquidum.tags.<name>, in the current locale; a
  # host describes its own tags the same way:
  #
  #   Liquidum::Tags.describe :signature_field, syntax: "signature_field kind signer"
  module Tags
    SYNTAX = {}
    # Not for writing by hand: an inline comment, documentation
    HIDDEN = %w[# doc].freeze

    module_function

    def describe(name, syntax:)
      SYNTAX[name.to_s] = syntax
    end

    def all
      Liquid::Environment.default.tags.to_h.filter_map do |name, tag|
        next if HIDDEN.include?(name)

        tag = tag.safe_constantize if tag.is_a?(String)
        {
          name: name,
          label: I18n.t(name, scope: "liquidum.tags", default: name.humanize),
          syntax: SYNTAX.fetch(name, name),
          block: !!(tag && tag < Liquid::Block)
        }
      end.sort_by { |tag| tag[:name] }
    end

    {
      "assign" => "assign variable = value", "capture" => "capture variable", "case" => "case variable",
      "cycle" => "cycle value, value", "decrement" => "decrement variable", "echo" => "echo value",
      "for" => "for item in collection", "if" => "if condition", "ifchanged" => "ifchanged",
      "include" => "include 'name'", "increment" => "increment variable", "render" => "render 'name'",
      "tablerow" => "tablerow item in collection", "unless" => "unless condition", "attach" => "attach value",
      "helper" => "helper name"
    }.each { |name, syntax| describe(name, syntax: syntax) }
  end
end
