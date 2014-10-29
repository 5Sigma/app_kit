class Invoice < ActiveRecord::Base
    belongs_to :customer
    has_many :invoice_items
    validates :customer, presence: true
    
    def to_s
        "Invoice ##{invoice_number}"
    end

end
