require_dependency "liquidum/application_controller"

module Liquidum
  # The tags a template can use, for an editor's completion after {%
  # (Liquidum::Tags), labelled in the request's locale:
  #
  #   GET /liquidum/tags → {tags: [{name, label, syntax, block}]}
  class TagsController < ApplicationController
    def index
      render json: {tags: Tags.all}
    end
  end
end
