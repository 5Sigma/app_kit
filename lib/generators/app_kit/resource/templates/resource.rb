AppKit.register <%= class_name %> do
  # Create a menu item for this resource in the main navigation bar.
  show_in_navigation true

  # Associate an icon with this item. FontAwesome is used to produce icons
  # This can be the name of any FontAwesome icon
  # icon 'user'
  # Field configuration
  # Possible field options can be
  #   show_in_table (true|false) to show in the field in tables
  #   show_in_details (true|false) to show the field when the record is viewed
  #   formatter (string) - a formatter that should be used to display the field
  #   hide - hides the field from both tables and detail views
<% @resource_class.column_names.each do |column_name| %>
  field :<%= column_name %><% end %>

  # Action definitions - Custom actions can be defined for the resource. This
  # will generate a link on the details page for the record to perform the 
  # given action
  #
  # action :some_action do |<%= class_name.underscore %>|
  #   <%= class_name.underscore %>.my_action(param: true)
  # end
end


