require_dependency "liquor/application_controller"

module Liquor
  class CompletionsController < ApplicationController
    def index
      q          = params[:q]
      klass      = q.classify.safe_constantize
      drop       = q.classify.concat('Drop').safe_constantize
      invokables = drop&.invokable_methods || []
      # drop_relations = klass.reflect_on_all_associations.map(&:name).select {|n| invokables.include?(n.to_s) }

      render json: { q: q, completions: invokables }
    end
  end
end
