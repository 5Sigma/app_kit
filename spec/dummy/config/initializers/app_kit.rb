AppKit.setup do
  title "Invoicer"
  dashboard do
    table :invoice, title: 'Open Invoices', :scope => :open
  end
end
