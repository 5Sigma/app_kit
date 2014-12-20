FactoryGirl.define do
  factory :invoice_item do
    invoice
    description "Some item"
    unit_price 1.99
    quantity 2
  end
end
