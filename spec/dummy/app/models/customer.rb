class Customer < ActiveRecord::Base
    validates :first_name, presence: true 
    validates :last_name, presence: true

    def name
        "#{first_name} #{last_name}"
    end

    def to_s
        name
    end
end
