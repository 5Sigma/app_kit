AppKit.register Invoice do 
    show_in_navigation true
    icon 'list'
    
    field :invoice_number, editable: false
    field :customer_id
    field :invoice_total, editable: false, :formatter => :currency 
    field :invoice_date, :formatter => :date

    before(:new) { |record| 
        record.invoice_number = "#{Time.current.year}#{Time.current.month}#{record.id}"
    }
    before(:create) { |record| 
        record.invoice_number = "#{Time.current.year}#{Time.current.month}#{record.id}"
    }

end
