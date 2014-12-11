require 'spec_helper'

RSpec.describe 'app_kit/_table.html.erb', :type => :view do
  context "with data" do
    before(:each) do
      FactoryGirl.create(:invoice)
      view.extend AppKit::PathHelper
      view.extend AppKit::FilterHelper
      view.extend AppKit::AttributeHelper
    end
    it "should render table" do
      table = AppKit::Views::Table.new(AppKit::Resource.find(:invoice))
      render 'app_kit/table', item: table
      expect(rendered).to have_selector('table')
    end
  end
  context "without data" do
    it "should not render table" do
      table = AppKit::Views::Table.new(AppKit::Resource.find(:invoice))
      render 'app_kit/table', item: table
      expect(rendered).to_not have_selector('table')
    end
    it "should render not found message" do
      table = AppKit::Views::Table.new(AppKit::Resource.find(:invoice))
      render 'app_kit/table', item: table
      expect(rendered).to have_content('No invoices found')
    end
  end
end
