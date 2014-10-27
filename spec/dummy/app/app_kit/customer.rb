AppKit.register Customer do
    format_column :phone_number, :as => :phone
    format_column :email, :as => :email
    show_in_navigation true
end
