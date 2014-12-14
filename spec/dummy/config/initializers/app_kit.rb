AppKit.setup do
  title "Invoicer"
  dashboard do
    table :invoice, title: 'Open Invoices', :resource_scope => :open
    table :invoice, title: 'Pending Invoices', :resource_scope => :unpublished
  end
end
