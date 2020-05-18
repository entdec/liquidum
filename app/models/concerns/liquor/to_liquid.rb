# frozen_literal_strings: true

module Liquor
  module ToLiquid
    extend ActiveSupport::Concern

    included do
      def to_liquid
        klass = "#{self.class.name}Drop".safe_constantize
        klass ||= "#{self.class.base_class.name}Drop".safe_constantize if self.class.respond_to?(:base_class)
        raise "No Drop defined for #{self.class.name}" unless klass

        klass.new(self)
      end
    end
  end
end
