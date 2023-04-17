module Liquidum
  class Sandbox < ApplicationRecord
    attribute :result, default: ''

    validates :context, presence: true
    validates :template, presence: true
  end
end
