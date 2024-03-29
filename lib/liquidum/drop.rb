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
          define_method(name) do
            if @object.class.respond_to?(:reflect_on_all_associations)
              relation = @object.class.reflect_on_all_associations.find do |a|
                a.name == name
              end
            end
            return unless relation

            klass = "#{relation.class_name}Drop".classify.safe_constantize

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
    end
  end
end
