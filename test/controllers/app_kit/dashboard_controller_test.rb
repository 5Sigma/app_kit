require 'test_helper'

module AppKit
  class DashboardControllerTest < ActionController::TestCase
    test "should get show" do
      get :show
      assert_response :success
    end

  end
end
