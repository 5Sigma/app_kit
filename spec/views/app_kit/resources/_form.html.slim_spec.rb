require 'spec_helper'
RSpec.describe 'app_kit/resources/_form.html.slim', :type => :view do
  let(:customer)  { FactoryGirl.create(:customer)}
  let(:resource) { AppKit::Resource.find(:customer)}
  before(:each) do
    allow(view).to receive(:resource).and_return(resource)
    assign(:record, customer)
  end
  it "should render form" do
    render
    expect(rendered).to have_selector('form')
  end
  describe "enum field" do
    let(:enum_field) {
      AppKit::Field.new(Customer,
                        :first_name,
                        enum: {open: 'Open', closed: 'Closed'})
    }
    it "should render enum field" do
      allow(resource).to receive(:editable_fields).and_return([enum_field])
      render
      expect(rendered).to have_selector('select')
      expect(rendered).to have_selector('select option[value=open]', text: 'Open')
      expect(rendered).to have_selector('select option[value=closed]', text: 'Closed')
    end
  end
end
