### Resources

Resources are the configuration object for a specific set of data, namely a
model. A resource should be defined for each model that the application needs to
build controllers and views for.

Resource files are expected to be in `app/app_kit`.


#### Generating resources

AppKit comes with a generator for creating resource files. From the root of your
rails project run:

    rails g app_kit:resource MODEL_NAME

This will create a new file inside the `app/app_kit/` folder with a default
configurations.

An example resource definition may look like this:

```ruby
AppKit.Register Invoice do
  show_in_navigation true
  icon 'list'

  field :invoice_number, editable: false
  field :invoice_total, editable: false, :formatter => :currency
  field :invoice_date, :formatter => :date
  field :published, show_in_table: false

  before(:new) { |record|
    record.invoice_number =  record.set_invoice_number
  }
end
```
##### Configuration commands
-   __show\_in\_navigation__ _(boolean)_ - If set to true a menu item will be
    created in the navigation for interacting with this model. _(defaults to
    true)_
-   __icon__ _(string)_ - A string value for the icon to use for this item. This
    icon is used in the menu and panel titles for the resource. AppKit uses
    font-awesome for creating icons/glyphs. This string should be the icon name
    from the font-awesome list.

##### Defining fields

Resource fields are the data attributes on the model that will be displayed when
viewing tables or records. Fields are defined with the field command:

```ruby
field model_name, options_hash
```

###### Field options
-   __editable__ _(boolean)_ - If set to true the field will be editable when
    editing a record. This will also control attribute whitelisting. _(default:
    true)_
-   __formatter__ _(symbol)_ - The formatting that should be used when
    displaying the fields value.
    -   __:string__ - No formatting is performed _(default)_
    -   __:number__ - Formats the value as a number with delimitation.
    -   __:currency__ - Formats the value as currency appending currency symbols,
        and delimiting numbers. It will also automatically round the number to
        two decimal places.
    -   __:date__ - Formats the value as a simple date without time information.
-   __show\_in\_table__ _(boolean)_ - Controls if the field should be used as a
    table column when listing records for this resource.
-   __show\_in\_detail__ _(boolean)_ - If false the field will not be displayed
    when viewing a given record. _(default: true)_
-   __hide__ _(boolean)_ -  This automatically sets both show\_in\_table and
    show\_in\_detail. _(default: false)_
-   __editor__ _(symbol)_ - The editor displayed for the field when editing a
    record. The default value is dependent on the fields data type.

##### Before actions

Before actions let you define small pieces of logic that should occure during
the execution of an action on a given resource.

```ruby
  before(:action_name) { |r|
    # some code to execute
  }
```
The action can be any of the standard restful actions `:index`, `:show`, `:new`,
`:create`, `:edit`, `:update`, or `:destroy`. The block of code is also passed
the record object that the action is currently acting on.
