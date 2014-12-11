require 'spec_helper'

RSpec.describe AppKit::ResourcesController, :type => :controller do
  controller(AppKit::ResourcesController) do

  end
  describe "#index" do
    it "should assign @records" do
      get :index
      expect(assigns(:records)).to_not be_nil
    end
  end
end
