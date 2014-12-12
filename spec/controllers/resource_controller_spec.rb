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
    context "filters" do
      let(:eq_params) {
        {invoice_filter: [{invoice_number: { value: 10 } }] }
      }
      let(:cont_params) {
        {invoice_filter: [{ invoice_number: { value: 1, condition: 'cont' } }]}
      }
      let(:ncont_params) {
        {invoice_filter: [{ invoice_number: { value: 1, condition: 'ncont' } }]}
      }
      let(:gt_params) {
        {invoice_filter: [{ invoice_total: { value: 10, condition: 'gt' } }]}
      }
      let(:lt_params) {
        {invoice_filter: [{ invoice_total: { value: 10, condition: 'lt' } }]}
      }
      let(:low_record) { FactoryGirl.create(:invoice,
                                            invoice_number: 5,
                                            invoice_total: 5) }
      let(:mid_record) { FactoryGirl.create(:invoice,
                                            invoice_number: 10,
                                           invoice_total: 10) }
      let(:high_record) { FactoryGirl.create(:invoice, invoice_number: 15,
                                            invoice_total: 15) }
      before(:each) do
        low_record
        mid_record
        high_record
      end

      it "should filter on eq" do
        get :index, eq_params
        expect(assigns(:records)).to_not include(high_record)
        expect(assigns(:records)).to include(mid_record)
      end

      it "should filter on contains" do
        get :index, cont_params
        expect(assigns(:records)).to include(mid_record)
        expect(assigns(:records)).to_not include(low_record)
      end

      it "should filter on not contains" do
        get :index, ncont_params
        expect(assigns(:records)).to_not include(mid_record)
        expect(assigns(:records)).to include(low_record)
      end

      it "should filter on gt" do
        get :index, gt_params
        expect(assigns(:records)).to_not include(low_record)
        expect(assigns(:records)).to include(high_record)
      end

      it "should filter on lt" do
        get :index, lt_params
        expect(assigns(:records)).to include(low_record)
        expect(assigns(:records)).to_not include(high_record)
      end

    end
  end
  describe "#new" do
    it "assigns @new" do
      get :new
      expect(assigns(:record)).to be_a_new(Invoice)
    end
  end
  describe "#create" do
    let(:valid_attributes) {
      {invoice: FactoryGirl.attributes_for(:invoice, customer_id: 4) }
    }
    let(:invalid_attributes) {
      { invoice: FactoryGirl.attributes_for(:invoice, customer_id: nil) }
    }
    context "with valid attributes" do
      it "should create new record" do
        expect {
          post :create, valid_attributes
        }.to change(Invoice, :count).by(1)
      end
    end
  end
end
