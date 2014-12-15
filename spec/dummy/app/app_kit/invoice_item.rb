AppKit.register InvoiceItem do
  show_in_navigation false
  icon 'list-alt'

  field :invoice_id
  field :description
  field :unit_price, :formatter => :currency
  field :quantity
  field :extended_price, :formatter => :currency
  field :created_at, show_in_table: false, editable: false
  field :updated_at, show_in_table: false, editable: false

end


