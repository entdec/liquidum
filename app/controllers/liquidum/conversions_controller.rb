module Liquidum
  class ConversionsController < ApplicationController
    before_action :set_objects
    class Conversion
      include ActiveModel::Model

      attr_accessor :source, :result
    end

    def index; end

    def create
      if params[:json_to_yaml] == 'commit'
        @conversion.result = YAML.dump(JSON.parse(@conversion.source))
      elsif params[:yaml_to_json] == 'commit'
        @conversion.result = JSON.pretty_generate(Psych.load(@conversion.source))
      elsif params[:slim_to_html] == 'commit'
        @conversion.result = Slim::Template.new({ pretty: true }) { @conversion.source }.render
      end

      render :index, status: 302
    end

    private

    def set_objects
      @conversion = Conversion.new(source: params.dig(:conversions_controller_conversion, :source) || '')
    end
  end
end
