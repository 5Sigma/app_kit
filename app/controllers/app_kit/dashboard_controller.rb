require_dependency "app_kit/application_controller"

module AppKit
  class DashboardController < ApplicationController
    def show
      @dashboard = AppKit.application.dashboard_view
    end
  end
end
