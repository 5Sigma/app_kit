require 'spec_helper'

class TestModel < ActiveRecord::Base; end


RSpec.describe AppKit::Views::Table do

  let(:table) {
    AppKit::Views::Table.new(:invoice,
                             :resource_scope => :open,
                             title: 'test_title')
  }
  let(:resource) { AppKit::Resource.find(:invoice) }
  describe "#initialize" do
    it "should set @resource" do
      expect(table.resource).to_not be_nil
    end
    it "should assign @resource_scope" do
      expect(table.resource_scope).to eq(:open)
    end
  end

  describe "#title" do
    context "when set with options hash" do
      it "should respond with title from options" do
        expect(table.title).to eq('test_title')
      end
    end
    context "when not set with options hash" do
      it "should respond with plural model name" do
        t = AppKit::Views::Table.new(:invoice)
        expect(t.title).to eq("Invoices")
      end
    end
  end

  describe "#records" do
    let(:open) {FactoryGirl.create(:invoice_published)}
    let(:paid) {FactoryGirl.create(:invoice_paid)}
    context "with scope" do
      it "should return scoped records" do
        expect(table.records).to eq([open])
      end
    end
    context "without scope" do
      it "should return all records" do
        t = AppKit::Views::Table.new(:invoice)
        expect(t.records).to eq([open,paid])
      end
    end
    context "with static records" do
      it "should return only statically given records" do
        FactoryGirl.create_list(:invoice_published, 5)
        FactoryGirl.create_list(:invoice_paid, 10)
        t = AppKit::Views::Table.new(:invoice, records: Invoice.open)
        expect(t.records.count).to eq(5)
      end
    end
  end


end
