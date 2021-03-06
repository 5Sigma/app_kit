class Customer < ActiveRecord::Base
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone_number, numericality: true

    has_many :invoices, :dependent => :destroy
    has_paper_trail

    def name
        "#{first_name} #{last_name}"
    end

    def to_s
        name
    end

end
