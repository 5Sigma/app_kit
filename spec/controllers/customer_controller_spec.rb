describe AppKit::CustomersController, :type => :controller do
  let(:customer) {FactoryGirl.create(:customer)}
  describe "get #index" do
    it "should assign @records" do
      get :index, :use_route => :app_kit
      expect(assigns(:records)).to eq([customer])
    end
    it "shoulder render index" do
      get :index, :use_route => :app_kit
      expect(response).to render_template "index"
    end
  end
  describe "get #show" do
    it "should assign @record" do
      get :show, id: customer.id, :use_route => :app_kit
      expect(assigns(:record)).to eq(customer)
    end
    it "should render resources/show" do
      get :show, id: customer.id, :use_route => :app_kit
      expect(response).to render_template "show"
    end
  end
  describe "get #edit" do
    it "should assign @record" do
      get :edit, id: customer.id, :use_route => :app_kit
      expect(assigns(:record)).to eq(customer)
    end
    it "should render edit template" do
      get :edit, id: customer.id, :use_route => :app_kit
      expect(response).to render_template('edit')
    end
  end
  describe "#destroy" do
    it "should remove a customer record" do
      customer
      expect {
        delete :destroy, id: customer.id, :use_route => :app_kit
      }.to change(Customer, :count).by(-1)
    end
  end
end
