# frozen_string_literal: true

module Liquor
  class ActiveModel::ErrorsDrop < Liquid::Drop
    def initialize(object)
      @object = object
    end
    delegate :base, :details, :messages, to: :@object
  end
end
