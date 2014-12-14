require_dependency "app_kit/application_controller"

module AppKit
  class DashboardController < ApplicationController
    def show
    end

    private
    def dashboard
      AppKit::application.dashboard
    end
    helper_method :dashboard
  end
end
