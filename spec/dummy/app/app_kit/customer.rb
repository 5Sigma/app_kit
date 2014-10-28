AppKit.register Customer do
    show_in_navigation true

    action :deactivate, :if => :active do |customer|
        customer.update(active: false)
    end
    
    field :name, editable: false
    field :first_name, show_in_table: false, show_in_details: false
    field :last_name, show_in_table: false, show_in_details: false
    field :email, formatter: :email
    field :phone_number, :formatter => :phone
    field :active
    field :created_at, show_in_table: false, editable: false
    field :updated_at, show_in_table: false, editable: false

end
