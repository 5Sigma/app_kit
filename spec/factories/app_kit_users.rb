FactoryGirl.define do
  factory :app_kit_user, class: AppKit::User do
    email 'test@example.com'
    password 'testtesttest'
    password_confirmation 'testtesttest'
  end
end
