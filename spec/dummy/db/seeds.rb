require "faker"
if AppKit::User.count == 0
  AppKit::User.create(email: 'admin@example.com', password: 'test1234', password_confirmation: 'test1234')
end
40.times do
  customer  = Customer.create(first_name:Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, phone_number: rand(9).to_s*10)
  rand(5).times do
    invoice = Invoice.create(customer: customer, invoice_date: Time.current, published: true, paid: true)
    (rand(3)+1).times do
      InvoiceItem.create(invoice: invoice, description: Faker::Commerce.product_name,
                         unit_price: rand(100), quantity: rand(10))
    end
  end
end
