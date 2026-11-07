# frozen_string_literal: true

module Liquidum
  # The variables available to a template, from its roots: the drops (or
  # plain values) it's rendered with.
  #
  #   variables = Liquidum::Variables.new(order: OrderDrop, portal_url: :string)
  #   variables.at("")                           # order, portal_url
  #   variables.at("order.customer")             # the customer's variables
  #   variables.at("order.order_lines.product")  # in a collection: an element's
  #
  # The editor asks for one level at a time (see Liquidum::VariablesController),
  # so associations that lead back (order → customer → orders) are no problem.
  # Hosts pass the roots signed, from .token, so a browser can't ask about
  # other classes.
  class Variables
    attr_reader :roots

    def initialize(roots)
      @roots = roots.to_h { |name, root| [name.to_s, root] }
    end

    def at(path)
      names = path.to_s.split(".")
      return roots.map { |name, root| root_variable(name, root) } if names.empty?

      first, *rest = names
      variable = root_variable(first, roots[first]) if roots.key?(first)
      rest.each { |name| variable = variable&.drop&.variables&.find { |v| v.name == name } }
      variable&.drop&.variables
    end

    def token
      self.class.verifier.generate(roots.transform_values { |root| root.is_a?(Class) ? {"drop" => root.name} : {"type" => root.to_s} })
    end

    class << self
      def from_token(token)
        roots = verifier.verified(token.to_s) or return

        new(roots.transform_values { |root| root["drop"] ? root["drop"].safe_constantize : root["type"] })
      end

      def verifier
        Rails.application.message_verifier("liquidum/variables")
      end
    end

    private

    def root_variable(name, root)
      if root.is_a?(Class) && root < Liquid::Drop
        model = root.model if root.respond_to?(:model)
        label = model.respond_to?(:model_name) ? model.model_name.human : name.humanize
        Variable.new(name: name, label: label, type: "object", hint: nil, drop: (root if root.respond_to?(:variables)), collection: false)
      else
        Variable.new(name: name, label: name.humanize, type: root&.to_s, hint: nil, drop: nil, collection: false)
      end
    end
  end
end
