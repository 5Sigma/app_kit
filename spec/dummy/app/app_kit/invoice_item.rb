AppKit.register InvoiceItem do 
    field :description
    field :invoice_id
    field :unit_price, :formatter => :currency
    field :extended_price, editable: false, :formatter => :currency
    field :quantity 
end
