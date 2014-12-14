AppKit.register InvoiceItem do
  show_in_navigation true
  icon 'list-alt'

  field :id
  field :invoice_id
  field :description
  field :unit_price, :formatter => :currency
  field :quantity
  field :extended_price, :formatter => :currency
  field :created_at
  field :updated_at

end


