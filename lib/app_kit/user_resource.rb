AppKit.register AppKit::User do
  show_in_navigation true, :right
  icon 'users'

  field :email
  field :password, show_in_details: false, show_in_table: false
  field :password_confirmation, show_in_details: false, show_in_table: false
end
