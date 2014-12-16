require 'spec_helper'

feature "UserManagements", :type => :feature do
  scenario "create a new user" do
    feature_login
    click_link 'Users'
    click_link 'New User'
    fill_in 'First name', with: 'Alice'
    fill_in 'Last name', with: 'Alison'
    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'test1234'
    fill_in 'Password confirmation', with: 'test1234'
    click_button 'Create User'
    expect(page).to have_content('Alice Alison')
    click_link 'logout'
    fill_in 'Email', with: 'alice@example.com'
    fill_in 'Password', with: 'test1234'
    click_button 'Log in'
    expect(page).to_not have_content 'Login'
  end
  scenario "edit user" do
    feature_login
  end
end
