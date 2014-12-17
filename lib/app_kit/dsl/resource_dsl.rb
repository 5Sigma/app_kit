module AppKit::Dsl::ResourceDsl

    # A DSL method for defining a new action.
    #
    # === Attributes
    #
    # * +name+ - The controller action to bind to.
    # * +options+ - An optional hash of params.
    # * +&block+ - The code to execute. This block is yielded the model instance
    #
    # === Examples
    #   action :update do |record|
    #       record.parent_record.update_information
    #   end
    #
    def action(name, options={}, &block)
      member_actions[name] = AppKit::Action.new(name, self, options, &block)
    end

    # A DSL method for defining fields and their options.
    #
    # @param name [Symbol] the field name. This should relate to a method name on the model.
    # @param options [Hash] an optional hash to list field options. For a full list of field options see the AppKit::Field class.
    # @param block [Block] If a block is passed a DSL can be used to define the fields settings, instead of passing them in the options hash.
    # @example Define a new field
    #   field :name, editable: false, display_in_details: false
    def field(name, options={}, &block)
      field = AppKit::Field.new(model, name, options, &block)
      fields << field
    end

    # DSL method for displaying resources in the main navigation bar.
    # @params val [boolean] - If true a menu item for this resrouce will be displayed in the main navigation menu.
    # @param position [:left,:right] the position for the navigation item
    def show_in_navigation(val=true, position = :left)
      if val == true
        nav_item = AppKit::NavigationItem.new
        nav_item.resource = self
        nav_item.position = position
        nav_item.icon = self.navigation_icon
        AppKit.application.navigation_items << nav_item
      else
        AppKit.application.navigation_items.delete_if {|i| i.resource == self}
      end
    end

    # DSL method for defining before_actions on resources.
    # @param action [Symbol] The action the before filter should execute for. Generally :new, :create, :update, or :destroy
    # @param block [Block] A block to execute. This block is given the record object.
    def before(action, &block)
      before_actions[action] = block if block_given?
    end

    # DSL method for defining an icon to be used in the navigation menu for this resource.
    # These icons use FontAwesome and should relate to the FontAwesome icon name.
    # @param icon [String] The FontAwesome icon name to use.
    # @example
    #   icon 'list'
    def icon(icon_name)
      self.navigation_icon = icon_name
    end
end
