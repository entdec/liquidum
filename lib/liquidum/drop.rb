# frozen_string_literal: true

module Liquidum
  class Drop < Liquid::Drop
    delegate :id, :errors, to: :@object

    def initialize(object)
      @object = object
    end

    def is_for_a?(klass)
      @object.is_a?(klass)
    end

    def to_gid
      @object.to_gid
    end

    def to_sgid
      @object.to_sgid
    end

    def to_h(max_level = 3, current_level: 0)
      return if current_level > max_level

      h = {}

      public_methods(false).each do |pm|
        result = send(pm)

        h[pm] = if result.is_a? ApplicationDrop
          result.to_h(max_level, current_level: current_level + 1)
        elsif result.is_a? Enumerator::Lazy
          result.map { |r| r.to_h(max_level, current_level: current_level + 1) }.force
        else
          result
        end
      end
      h
    end

    class << self
      def association(*associations)
        associations.each do |name|
          self.associations << name.to_s

          define_method(name) do
            if @object.class.respond_to?(:reflect_on_all_associations)
              relation = @object.class.reflect_on_all_associations.find do |a|
                a.name == name
              end
            end
            return unless relation

            klass = Drop.for_relation(relation)

            Rails.logger.warn "No #{klass}" and return unless klass

            if relation.collection?
              # FIXME: The LazyDrop has unexpected side effects for exisiting templates, this needs to be discussed further
              # Enumerator::LazyDrop.new(@object.send(name).lazy.map { |o| klass.new(o) })
              @object.send(name).map { |o| klass.new(o) }
            else
              klass.new(@object.send(name)) unless @object.send(name).nil?
            end
          end
        end
      end

      # Adds to what Liquidum works out about a variable for the editor's
      # variable picker (see .variables):
      #
      #   describe :total, type: :money, hint: "Including VAT"
      #   describe :portal_url, label: -> { I18n.t("orders.portal_url") }
      #   describe :owner, drop: "UserDrop"
      #   describe :tags, drop: "TagDrop", collection: true
      #
      # A label or hint can be a proc, to translate it in the current locale.
      def describe(name, label: nil, type: nil, hint: nil, drop: nil, collection: nil)
        descriptions[name.to_s] = {label: label, type: type, hint: hint, drop: drop, collection: collection}.compact
      end

      def descriptions
        @descriptions ||= superclass.respond_to?(:descriptions) ? superclass.descriptions.dup : {}
      end

      def associations
        @associations ||= superclass.respond_to?(:associations) ? superclass.associations.dup : []
      end

      # The model the drop is for, for labels, types and associations:
      # OrderDrop is for Order. Override it when the names don't match.
      def model
        name&.delete_suffix("Drop")&.safe_constantize
      end

      # The variables a template can use on this drop, one level deep, with
      # labels in the current locale. Only what Liquid can call is listed, so
      # not the helpers every Liquidum::Drop has (to_gid, to_h, …).
      def variables
        (invokable_methods - HELPERS).sort.filter_map do |name|
          next if instance_method(name).parameters.any? { |kind, _| kind == :req }

          variable(name)
        end
      end

      def for_relation(relation)
        "#{relation.class_name}Drop".classify.safe_constantize
      end

      private

      def variable(name)
        description = descriptions.fetch(name, {})
        relation = model.reflect_on_association(name) if associations.include?(name) && model.respond_to?(:reflect_on_association)
        drop = description[:drop]&.to_s&.safe_constantize || (for_relation(relation) if relation)

        Variable.new(
          name: name,
          label: resolve(description[:label]) || label_for(name),
          type: (description[:type] || (drop ? :object : attribute_type(name)))&.to_s,
          hint: resolve(description[:hint]),
          drop: drop,
          collection: description.fetch(:collection) { relation&.collection? || false }
        )
      end

      def label_for(name)
        model.respond_to?(:human_attribute_name) ? model.human_attribute_name(name) : name.humanize
      end

      def attribute_type(name)
        return unless model.respond_to?(:attribute_types) && model.attribute_types.key?(name)

        model.attribute_types[name].type
      end

      def resolve(value)
        value.respond_to?(:call) ? value.call : value
      end
    end

    HELPERS = (public_instance_methods(false).map(&:to_s) - %w[id]) + %w[to_liquid]
  end
end
