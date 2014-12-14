AppKit.setup do
  title "Invoicer"
  disable_authentication
  dashboard do
    table :invoice, title: 'Open Invoices', :scope => :open
  end
end
