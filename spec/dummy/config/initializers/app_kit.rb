AppKit.setup do |config|
  dashboard do
    table :invoice, title: 'Open Invoices', :scope => :open
  end
end
