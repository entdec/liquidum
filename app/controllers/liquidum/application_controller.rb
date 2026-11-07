module Liquidum
  class ApplicationController < Liquidum.config.parent_controller.constantize
    protect_from_forgery with: :exception
  end
end
