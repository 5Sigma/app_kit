require "faker"

10.times do 
    Customer.create(first_name:Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, phone_number: rand(9).to_s*10)
end
