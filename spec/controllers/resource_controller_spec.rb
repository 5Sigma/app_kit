require 'spec_helper'

RSpec.describe AppKit::ResourcesController, :type => :controller do
  controller(AppKit::ResourcesController) do
    self.resource = AppKit::Resource.find(:invoice)
  end
  before(:each) do
    sign_in FactoryGirl.create(:app_kit_user)
  end
  describe "#index" do
    it "should assign @records" do
      get :index
      expect(assigns(:records)).to eq(Invoice.all.page(0))
    end
    it "should filter records for cont" do
      record = FactoryGirl.create(:invoice, invoice_number: 10)
      get :index, invoice_filter: { invoice_number: 1 }
      expect(assigns(:records)).to_not include(record)
    end
  end
end
