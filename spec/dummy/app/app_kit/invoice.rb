AppKit.register Invoice do 
    show_in_navigation true
    
    field :customer_id
    field :invoice_number
    field :invoice_total
    field :invoice_date, :formatter => :date

end
