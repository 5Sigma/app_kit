class Invoice < ActiveRecord::Base
    belongs_to :customer
    has_many :invoice_items, :dependent => :destroy
    validates :customer_id, presence: true

    scope :open, ->{ where(paid: false, published: true) }

    def to_s
        "Invoice ##{invoice_number}"
    end

end
