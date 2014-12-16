AppKit.setup do
  title "Invoicer"
  navigation_item 'Reporting', :reporting, 'line-chart'
  dashboard do
    table :invoice, title: 'Open Invoices', :resource_scope => :open
    table :invoice, title: 'Pending Invoices', :resource_scope => :unpublished
  end
end
