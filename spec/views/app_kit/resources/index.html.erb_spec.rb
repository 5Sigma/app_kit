RSpec.describe 'app_kit/resources/index.html.erb', :type => :view do
  let(:resource) { AppKit::Resource.find(:invoice) }
  before(:each) do
    allow(view).to receive(:resource).and_return(resource)
    view.extend AppKit::PathHelper
    view.extend AppKit::FilterHelper
    view.extend AppKit::AttributeHelper
  end
  context "with data" do
    before(:each) do
      FactoryGirl.create(:invoice)
      assign(:records, Invoice.all.page(0))
    end
    it "should display table" do
      render
      expect(rendered).to have_selector('table')
    end
    it "should render table row for each record" do
      FactoryGirl.create_list(:invoice_published, 5)
      FactoryGirl.create_list(:invoice_paid, 5)
      assign(:records, Invoice.open.page(1))
      render
      expect(rendered).to have_selector('table tbody tr', count: 5)
    end
  end
  context "without data" do
    before(:each) do
      assign(:records, Invoice.all.page(0))
    end

    it "should not render table" do
      render
      expect(rendered).to_not have_selector("table")
    end
  end
  it "should show new button" do
    assign(:records, Invoice.all.page(0))
    render
    expect(rendered).to have_selector("a", text: 'New Invoice')
  end
end
