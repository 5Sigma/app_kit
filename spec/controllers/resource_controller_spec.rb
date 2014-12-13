require 'spec_helper'

RSpec.describe AppKit::ResourcesController, :type => :controller do
  controller(AppKit::ResourcesController) do
    self.resource = AppKit::Resource.find(:invoice)
  end
  let(:invoice) { FactoryGirl.create(:invoice) }
  let(:valid_attributes) {
    {invoice: FactoryGirl.attributes_for(:invoice, customer_id: 4) }
  }
  let(:invalid_attributes) {
    { invoice: FactoryGirl.attributes_for(:invoice, customer_id: nil) }
  }
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
    context "with valid attributes" do
      it "should create new record" do
        expect {
          post :create, valid_attributes
        }.to change(Invoice, :count).by(1)
      end
    end
  end
  describe "#show" do
    it "should assign @record" do
      get :show, id:invoice.id
      expect(assigns(:record)).to eq(invoice)
    end
  end
  describe "#edit" do
    it "should assign @record" do
      get :edit, id:invoice.id
      expect(assigns(:record)).to eq(invoice)
    end
  end
  describe "#update" do
    context "with valid attributes" do
      it "should update record" do
        patch :update, valid_attributes.merge({id:invoice.id})
        invoice.reload
        expect(invoice.customer_id).to eq(4)
      end
      it "should redirect" do
        patch :update, valid_attributes.merge({id:invoice.id})
        expect(response).to be_redirect
      end
    end
    context "with invalid attributes" do
      before(:each) do
        allow_any_instance_of(Invoice).to receive(:update).and_return(false)
      end
      it "should assign @record" do
        patch :update, valid_attributes.merge({id:invoice.id})
        expect(assigns(:record)).to eq(invoice)
      end
      it "should render edit" do
        patch :update, valid_attributes.merge({id:invoice.id})
        expect(response).to render_template('edit')

      end
    end
  end
  describe "#destroy" do
    it "should delete record" do
      invoice
      expect {
        delete :destroy, id: invoice.id
      }.to change(Invoice, :count).by(-1)
    end
    it "should redirect to invoice" do
        delete :destroy, id: invoice.id
        expect(response).to be_redirect
    end
  end
end
