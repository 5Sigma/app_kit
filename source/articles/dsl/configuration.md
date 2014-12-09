### Configuration

Application configuration is done in the initialization file install by running
the installation generator. This file is placed in
`config/initializers/app_kit.rb`.

#### Dashboard

The dashboard must be setup from this file, since it does not have an associated
resource, or model. The dashboard is meant to be a collection of useful overview
information for the user.

<a id="tables" name="tables"></a>
##### Tables

The primary purpose of the dashboard is to display specific types of tabular
data. Tables are created by the table command.

```ruby
AppKit.setup do |config|
  dashboard do
    table :invoice, title: 'Open Invoices', :scope => :open
  end
end
```
-   __title__ _(string)_ - The title of the table. If not specified the plural
    name of the resource will be used.
-   __scope__ _(symbol)_ - The name of a scope to be used. This scope should be
      defined on the model. If not specified all records will be returned.
