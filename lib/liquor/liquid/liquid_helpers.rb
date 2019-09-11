# frozen_string_literal: true

module Liquor
  module LiquidHelpers
    private

    def initialize(tag, args, tokens)
      begin
        @args = Liquor::Tag::Parser.new(args).args
      rescue Parslet::ParseFailed => e
        raise Parslet::ParseFailed, e.message + " (#{tag} #{args})"
      end
      super
    end

    def render(context)
      @context = context
    end

    def render_body
      @body.render(@context)
    end

    # Return named argument
    def arg(name)
      raise 'No @context set' unless @context

      attr = @args.find { |a| a[:attr] == name.to_s }
      return unless attr

      if attr.key? :value
        attr[:value].to_s
      elsif attr.key? :lvalue
        lookup(@context, attr[:lvalue].to_s)
      end
    end

    # Returns the first argument - usually reserved for literal or quoted values, not for attribute value pairs
    # When the first attribute is a pair, it will return nil
    def argv1
      raise 'No @context set' unless @context

      argv1 = @args[0]
      return unless argv1

      if argv1.key? :quoted
        argv1[:quoted].to_s
      elsif argv1.key? :literal
        @context.key?(argv1[:literal].to_s) ? @context[argv1[:literal].to_s] : argv1[:literal].to_s
      end
    end

    # Returns the standalone arguments
    def sargs
      raise 'No @context set' unless @context

      @args.slice(1..-1).select { |a| a.key?(:quoted) || a.key?(:literal) }.map do |a|
        if a.key? :quoted
          a[:quoted].to_s
        elsif a.key? :literal
          lookup(@context, a[:literal].to_s) || a[:literal]
        end
      end
    end

    # Returns the attribute-value-pair arguments as a hash
    def attr_args
      raise 'No @context set' unless @context

      result = {}
      @args.select { |a| a.key?(:value) || a.key?(:lvalue) || a.key?(:svalue) }.map do |a|
        if a.key? :value
          result[a[:attr].to_sym] = a[:value].to_s
        elsif a.key? :lvalue
          result[a[:attr].to_sym] = lookup(@context, a[:lvalue].to_s) || a[:lvalue]
        elsif a.key? :svalue
          result[a[:attr].to_sym] = a[:svalue].to_sym
        end
      end
      result
    end

    # Returns an attribute string if the attribute has a value, for use in making HTML
    #
    # @param [Symbol] attr
    # @param [Object] value
    # @param [Object] default
    # @return [String]
    def attr_str(attr, value, default = nil)
      v = value || default
      v.present? ? " #{attr}=\"#{v}\"" : ''
    end

    def attrs_str(*attrs, reject: [])
      attrs = @args.map { |a| a[:attr] }.reject { |a| a.nil? || reject.include?(a) } if attrs.empty?

      result = []
      attrs.each do |attr|
        result << attr_str(attr, arg(attr))
      end
      result.join
    end

    # Lookup allows access to the assigned variables through the context
    def lookup(context, name)
      return unless name

      context[name]
    end

    # For use with forms and inputs
    def input(purpose, name)
      form_model      = lookup(@context, 'form.model')
      form_class_name = lookup(@context, 'form.class_name')

      # binding.pry if name == 'postal_code'

      # order[order_lines_attributes][xxxx][product_name]
      #
      # order[order_attributes]_[lines_attributes][][product_name]

      parts = @context.scopes.select { |scope| scope.key? 'form' }.map do |scope|
        if scope['form'].attribute
          scope['form'].attribute.to_s.gsub(/([a-z\-\_]+)/) { "[#{Regexp.last_match(1)}_attributes]" }.gsub(/\[\]$/, "[#{SecureRandom.uuid}]")
        else
          scope['form'].class_name.underscore.gsub('/', '_')
        end
      end
      parts = parts.unshift("[#{name}]").reverse

      return unless form_model && form_class_name && name

      case purpose
      when :id
        parts.join('_').gsub('][', '_').tr('][', '')
      when :value
        # This is executed on the drop, drops provide the values for the form
        form_model.send(name.to_sym)
      when :name
        # The original class's name dictates the name of the fields
        parts.first + parts.slice(1..-1).join
      when :error
        parts.slice(1..-1).join('.')
      when :checked
        'checked' if (input(:value, name) ? 1 : 0) == 1
      end
    end

    # Returns the path for the input from the main form, say: origin.contact_name
    def path_for_input(name)
      parts = @context.scopes.select { |scope| scope.key? 'form' }.select { |scope| scope['form'].attribute }.map do |scope|
        scope['form'].attribute
      end
      parts = parts.unshift(name.to_s).reverse
      parts.join('.')
    end

    def real_object_from_drop(drop)
      drop.instance_variable_get('@object')
    end
  end
end
