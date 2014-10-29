class InvoiceItem < ActiveRecord::Base
    belongs_to :invoice

    before_save :update_extended_price
    after_save :update_invoice


    def update_extended_price
        self.extended_price = self.unit_price * self.quantity
    end

    def update_invoice
        self.invoice.update(invoice_total: self.invoice.invoice_items.sum(:extended_price))
    end

    def to_s
        description
    end


end
