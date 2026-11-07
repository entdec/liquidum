require_dependency "liquidum/application_controller"

module Liquidum
  # The variables at a path, for an editor's variable picker:
  #
  #   GET /liquidum/variables?roots=<Liquidum::Variables#token>&path=order.customer
  #
  # Only describes the variables; it never reads a record.
  class VariablesController < ApplicationController
    def index
      variables = Variables.from_token(params[:roots]) or return head(:bad_request)
      found = variables.at(params[:path]) or return head(:not_found)

      render json: {path: params[:path].to_s, variables: found}
    end
  end
end
