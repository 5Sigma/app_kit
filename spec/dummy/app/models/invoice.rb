class Invoice < ActiveRecord::Base
    belongs_to :customer
    validates :customer, presence: true
    
    def to_s
        "Invoice ##{invoice_number}"
    end

end
