AppKit.register Customer do
    show_in_navigation true

    action :deactivate, :if => :active do |customer|
        customer.update(active: false)
    end

    field :name 
    field :email, formatter: :email
    field :phone_number, :formatter => :phone
    field :created_at, show_in_table: false
    field :updated_at, show_in_table: false

end
