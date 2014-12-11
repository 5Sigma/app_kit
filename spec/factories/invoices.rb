FactoryGirl.define do
  factory :invoice do
    customer
    invoice_number 123
    invoice_date Time.current
    paid false
    published false
    factory :invoice_paid do
      published true
      paid true
    end
    factory :invoice_published do
      published true
    end

  end
end
