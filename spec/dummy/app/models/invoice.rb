class Invoice < ActiveRecord::Base
  belongs_to :customer
  has_many :invoice_items, :dependent => :destroy
  validates :customer_id, presence: true

  scope :open, ->{ where(paid: false, published: true) }
  scope :unpublished, ->{where(published: false)}


  after_create :set_invoice_number


  def set_invoice_number
    unless self.invoice_number
      self.invoice_number = "#{Time.current.year}#{Time.current.month}#{self.id}"
      self.save
    end
  end

  def to_s
    "Invoice ##{invoice_number}"
  end

end
