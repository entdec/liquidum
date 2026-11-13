module Liquidum
  class Sandbox < ApplicationRecord
    attribute :result, default: ""

    validates :context, presence: true
    validates :template, presence: true
    validate :context_is_a_json_object

    # The context as the template's variables
    def assigns
      JSON.parse(context.to_s)
    rescue JSON::ParserError
      {}
    end

    private

    def context_is_a_json_object
      return if context.blank?

      errors.add(:context, :not_a_json_object) unless JSON.parse(context).is_a?(Hash)
    rescue JSON::ParserError => e
      errors.add(:context, :invalid_json, message: e.message)
    end
  end
end
