require 'spec_helper'

feature "ResourceOperations", :type => :feature do
  scenario "view feature index" do
    feature_login
    FactoryGirl.create(:invoice, invoice_number: '123312')
    click_link 'Invoices'
    expect(page).to have_selector('table tbody tr td', text: '123312')
  end
  scenario "Create new resource item" do
    feature_login
    click_link 'Customers'
    click_link 'New Customer'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Email', with: 'john@doe.com'
    fill_in 'Phone number', with: '4025557878'
    select 'Yes', from: 'Active'
    click_button 'Create Customer'
    expect(page).to have_selector('.kv-value', text: 'John Doe')
  end
  scenario "Edit resource item" do
    feature_login
    customer = FactoryGirl.create(:customer)
    visit app_kit.customer_path(customer)
    click_link 'edit details'
    fill_in 'First name', with: 'TestFirstName'
    fill_in 'Last name', with: 'TestLastName'
    click_button 'Update Customer'
    expect(page).to have_selector('.kv-value',text: 'TestFirstName TestLastName')
  end
  scenario "create nested resource" do
    customer = FactoryGirl.create(:customer)
    feature_login
    visit app_kit.customer_path(customer)
    click_link 'Create'
    select 'No', from: 'Paid'
    select 'No', from: 'Published'
    click_button 'Create Invoice'
    expect(page).to have_selector('.kv-value',
                                  text: Invoice.last.invoice_number)
    expect(page).to have_selector(".kv-value a", text: customer.to_s)
  end
  scenario "view nested resource" do
    feature_login
    customer = FactoryGirl.create(:customer)
    invoice = FactoryGirl.create(:invoice, customer: customer)
    visit app_kit.customer_path(customer)
    expect(page).to have_selector('table tbody tr td',
                                  text: invoice.invoice_number)
  end
end
