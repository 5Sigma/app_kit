require 'spec_helper'

RSpec.describe AppKit::AttributeHelper, :type => :helper do
  let(:customer) { FactoryGirl.create(:customer) }
  it "should call formatting method" do
    field = AppKit::Field.new(Customer, :phone_number, :formatter => :test)
    expect(helper).to receive(:format_test)
    helper.format_attribute(customer,field)
  end
  it "should format field with block" do
    field = AppKit::Field.new(Customer, :name) {|r|
      "#{r.first_name} #{r.last_name}"
    }
    expect(
      helper.format_attribute(customer,field)
    ).to eq("#{customer.first_name} #{customer.last_name}")
  end
end


