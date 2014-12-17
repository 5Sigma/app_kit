require 'spec_helper'

RSpec.describe AppKit::Association do
  describe "#initialize" do
    let(:association) {
      AppKit::Association.new(Customer.reflect_on_all_associations.first)
    }
    it "should set associated model" do
      expect(association.associated_model).to eq(Invoice)
    end
    it "should set foreign key" do
      expect(association.foreign_key).to eq("customer_id")
    end
    it "should set association_type" do
      expect(association.association_type).to eq(:has_many)
    end
    it "should set owner_model" do
      expect(association.owner_model).to eq(Customer)
    end
    it "should set association name" do
      expect(association.association_name).to eq(:invoices)
    end
  end
end
