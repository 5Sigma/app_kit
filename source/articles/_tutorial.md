### Generating a new project

To get started we will setup a new rails project.

    rails new crm

This will create a new folder called `crm` with your project files in it. The
first thing we need to do is add AppKit to it. Open the file `Gemfile` and add
the following line somewhere in the file.

```ruby
gem 'app_kit'
```

Then run the bundle command:

    bundle

This will install the AppKit gem and all of its dependencies as well as set them
up in your project.

To setup the project run the AppKit install generator. This will create a
migration for the users table and install an initializer.

    rails g app_kit:install

<a id="models" name="models"></a>
### Setting up data models

We will use the default database settings for Rails, which is Sqlite3 and
ActiveRecord. To create a few models we can use Rails' built in generators.

    rails g model customer
    rails g model invoice
    rails g model invoice_item

Edit the customer migration created in `db/migrate/XXXXXXXX_create_customer.rb`.

```ruby
class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.string :email
      t.string :active
      t.timestamps
    end
  end
end
```

Edit the invoice migration created at `db/migrate/XXXXXXX_create_invoices`.

```ruby
class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.belongs_to :customer
      t.integer :invoice_number
      t.decimal :invoice_total
      t.datetime :invoice_date
      t.boolean :paid
      t.boolean :published
      t.timestamps
    end
  end
end
```
Edit the invoice\_item migration created at
`db/migrate/XXXXXX_create_invoice_items`.

```ruby
class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.belongs_to :invoice
      t.string :description
      t.decimal :unit_price
      t.decimal :quantity
      t.decimal :extended_price
      t.timestamps
    end
  end
end
```

Migrate your database to create the tables.

    rake db:migrate

Next add your associations to your model files located in `app/model/`.

```ruby
#customer.rb
class Customer < ActiveRecord::Base
  has_many :invoices
end

#invoice.rb
class Invoice < ActiveRecord::Base
  belongs_to :customer
end

#invoice_item.rb
class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
end
```

<a id="resources" name="resources"></a>
### Defining AppKit resources

From the root of your project run the `app_kit:resource` generator for each
model.

    app_kit:resource customer
    app_kit:resource invoice
    app_kit:resource invoice_item

The generated resource files will have many commented lines that can be used as
a quick syntax reference. For the sake of brevity those will be ignored below.

The resource files will be generated with default options for all the database
fields in the tables. We will tweak them just a bit to improve the setup.

<a id="customer-resource" name="customer-resource"></a>
#### Customer resource

Open the customer resource file located at `app/app_kit/customer.rb`.

```ruby
AppKit.register Customer do
    show_in_navigation true
    icon 'user'

    action :deactivate, :if => :active do |customer|
        customer.update(active: false)
    end

    field :name, :sort_field => :first_name
    field :first_name, show_in_table: false, show_in_details: false
    field :last_name, show_in_table: false, show_in_details: false
    field :email, formatter: :email
    field :phone_number, :formatter => :phone
    field :active
    field :created_at, show_in_table: false, editable: false
    field :updated_at, show_in_table: false, editable: false

end
```

<a id="invoice-resource" name="invoice-resource"></a>
#### Invoice resource

Open the invoice resource file located at `app/app_kit/invoice.rb`.

```ruby
AppKit.register Invoice do
    show_in_navigation true

    icon 'list'
    field :invoice_number, editable: false
    field :customer_id
    field :invoice_total, editable: false, :formatter => :currency
    field :invoice_date, :formatter => :date
end
```

<a id="invoice-item-resource" name="invoice-item-resource"></a>
#### Invoice item resource

Open the invoice\_item resource file located at `app/app_kit/invoice.rb`.

```ruby
AppKit.register InvoiceItem do
    field :description
    field :invoice_id
    field :unit_price, :formatter => :currency
    field :extended_price, editable: false, :formatter => :currency
    field :quantity
end
```

<a id="user" name="user"></a>
### Create a user account

AppKit automatically handles user authorization so you will need an initial
user in order to access the application. The quickest way to create a user
is through the rails console by running the command

    rails console

Once in the rails console run the following code (You can change the name and
password if you would like):

```ruby
AppKit::User.create(
  first_name: 'John',
  last_name: 'Doe',
  password: 'some passphrase',
  password_confirmation: 'some passphrase'
)
```

### Finished

Thats it run the rails server and open a browser to `http://localhost:3000`.

    rails server
