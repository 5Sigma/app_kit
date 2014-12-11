require "spec_helper"

describe "AppKit resource registration" do
  describe "controller creation" do
    it "should create controller" do
      expect(defined?(AppKit::InvoicesController)).to eq("constant")
    end
    it "should assign resource to controller" do
      invoice_resource = AppKit::Resource.find(:invoice)
      expect(AppKit::InvoicesController.resource).to eq(invoice_resource)
    end
    it "should assign controller_name to resource" do
      invoice_resource = AppKit::Resource.find(:invoice)
      expect(invoice_resource.controller_name).to eq('invoices')
    end
    it "should setup viewpaths" do
      paths = AppKit::InvoicesController.view_paths.map(&:to_s)
      expect(paths).to include(File.join(Rails.root,'app/views/invoices'))
    end
  end
  describe "routing", :type => :routing  do
    routes { AppKit::Engine.routes }
    it "should create resource routes" do
      expect(:get => 'invoices').to be_routable
      expect(:get => 'invoices/1').to be_routable
      expect(:get => 'invoices/new').to be_routable
      expect(:post => 'invoices/').to be_routable
      expect(:delete => 'invoices/1').to be_routable
      expect(:get => 'invoices/1/edit').to be_routable
      expect(:patch => 'invoices/1').to be_routable
    end
  end
end
