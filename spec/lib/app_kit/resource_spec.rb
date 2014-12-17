require "spec_helper"

describe AppKit::Resource do

  let(:resource) {
    r = AppKit::Resource.new(Customer)
    r.field(:first_name)
    r
  }

  describe "#field" do
    it "should add to fields list" do
      expect {
        resource.field(:test)
      }.to change(resource.fields, :count).by(1)
    end
    it "should create a new field" do
      resource.field(:test)
      expect(resource.fields.map(&:name)).to include(:test)
    end
  end
  describe "#show_in_navigation" do
    context "when set to false" do
      it "should remove from navigation list" do
        resource.show_in_navigation true
        expect {
          resource.show_in_navigation false
        }.to change(AppKit.application.navigation_items, :count).by(-1)
      end
    end
    context "when set to true" do
      it "should add the resource to the RESOURCES list" do
        resource.show_in_navigation false
        expect {
          resource.show_in_navigation true
        }.to change(AppKit.application.navigation_items, :count).by(1)
        resource.show_in_navigation false
      end
    end
  end
  describe "#icon" do
    it "should set the navigation_icon" do
      resource.icon('test_icon')
      expect(resource.navigation_icon).to eq('test_icon')
    end
  end
  describe "#display_name" do
    it "should create a human readable display name" do
      expect(resource.model).to receive(:name).and_return('TestModel')
      expect(resource.display_name).to eq("Test model")
    end
  end
  describe "#plural_display_name" do
    it "should create a huamn readable and plural name" do
      expect(resource.model).to receive(:name).and_return('TestModel')
      expect(resource.plural_display_name).to eq("Test models")
    end
  end
  describe "#table_fields" do
    let(:field) { resource.fields.first }
    it "should only include fields with show_in_table: true" do
      field.show_in_table false
      expect(resource.table_fields).to_not include(field)
      field.show_in_table true
      expect(resource.table_fields).to include(field)
    end
  end
  describe "#detail_fields" do
    let(:field) { resource.fields.first }
    it "should only include fields with show_in_table: true" do
      field.show_in_details false
      expect(resource.detail_fields).to_not include(field)
      field.show_in_details true
      expect(resource.detail_fields).to include(field)
    end
  end
  describe "#editable_fields" do
    let(:field) { resource.fields.first }
    it "should only include fields with editable: true" do
      field.editable false
      expect(resource.editable_fields).to_not include(field)
      field.editable true
      expect(resource.editable_fields).to include(field)
    end
  end
  describe "#before" do
    it "should add to before_actions array" do
      resource.before(:test) {|r| puts "test" }
      expect(resource.before_actions.keys).to include(:test)
    end
  end
  describe "#action" do
    it "should add action object to #member_actions" do
      resource.action(:test_action) { puts "test" }
      expect(resource.member_actions[:test_action]).to be_a(AppKit::Action)
    end
  end
end
