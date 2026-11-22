require_dependency "liquidum/application_controller"

module Liquidum
  # The filters a template can use, for an editor's completion after a |
  # (Liquidum::Filters), labelled in the request's locale:
  #
  #   GET /liquidum/filters → {filters: [{name, label, arguments: [{name, kind}], keeps}]}
  class FiltersController < ApplicationController
    def index
      render json: {filters: Filters.all}
    end
  end
end
