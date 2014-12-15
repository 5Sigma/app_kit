require 'spec_helper'

RSpec.describe 'app_kit/resources/show.html.slim', :type=>:view do
  let(:resource) { AppKit::Resource.find(:invoice) }
  before(:each) do
    allow(view).to receive(:resource).and_return(resource)
    view.extend AppKit::PathHelper
    view.extend AppKit::FilterHelper
    view.extend AppKit::AttributeHelper
    invoice = FactoryGirl.create(:invoice)
    assign(:record, invoice)
  end
  it "should display all detail fields" do
    render
    resource.detail_fields.each do |field|
      expect(rendered).to have_selector('span.kv-key',
                                        text: field.display_name)
    end
  end
  it "should render tables for association" do
    render
    expect(rendered).to have_selector('.panelkit',
                                      count: resource.has_many_associations.count+1)
  end
end
