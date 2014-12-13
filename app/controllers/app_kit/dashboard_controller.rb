require_dependency "app_kit/application_controller"

module AppKit
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    def show
    end

    private
    def dashboard
      AppKit::application.dashboard
    end
    helper_method :dashboard
  end
end
