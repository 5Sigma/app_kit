ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
Rails.backtrace_cleaner.remove_silencers!
# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
include Devise::TestHelpers
Capybara.asset_host = 'http://localhost:3000'
require "database_cleaner"
RSpec.configure do |config|
  config.mock_with :rspec
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.before :each do
    if Capybara.current_driver == :rack_test
      DatabaseCleaner.strategy = :transaction
    else
      DatabaseCleaner.strategy = :truncation
    end
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

end



def feature_login(user=nil)
  user = FactoryGirl.create(:app_kit_user) unless user
  visit '/'
  fill_in 'Email', with: 'test@example.com'
  fill_in 'Password', with: 'testtesttest'
  click_button 'Log in'
  expect(page).to_not have_content('Login')
  user
end

def with_versioning
  was_enabled = PaperTrail.enabled?
  was_enabled_for_controller = PaperTrail.enabled_for_controller?
  PaperTrail.enabled = true
  PaperTrail.enabled_for_controller = true
  begin
    yield
  ensure
    PaperTrail.enabled = was_enabled
    PaperTrail.enabled_for_controller = was_enabled_for_controller
  end
end


