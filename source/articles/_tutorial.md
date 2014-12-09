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


### Setting up data models

We will use the default database settings for Rails, which is Sqlite3 and
ActiveRecord. To create a few models we can use Rails' built in generators.

    rails g model customer
    rails g model invoice
    rails g model invoice_item

Edit the customer migration created in `db/migrate/XXXXXXXX_create_customer.rb`.

```ruby
class CreateCustomers << ActiveRecord::migration
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
class CreateInvoices << ActiveRecord::migration
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
### Defining AppKit resources

From the root of your project run the `app_kit:resource` generator for each
model.

    app_kit:resource customer
    app_kit:resource invoice
    app_kit:resource invoice_item

The generated resource files will have many commented lines that can be used as
a quick syntax reference. For the sake of brevity those will be ignored below.

#### Customer resource

Open the customer resource file located at `app/app_kit/customer.rb`.

