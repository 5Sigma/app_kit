module AppKit
  # The resource class manages a model and contains most of the functionality for
  # dynamically interacting with the model. It also contains all the settings given
  # in the DSL.
  # The resource DSL is evaluated within this class.
  class Resource
    attr_writer :hidden_fields, :editors, :formatters, :member_actions,
      :editable_fields

    # The model class that this resource manages.
    attr_accessor :model

    # A string tha represents a icon used in the navigation menu.
    # Taken from FontAwesome and is set using the #icon DSL method.
    attr_accessor :navigation_icon

    # The name of the controller this resource manages.
    attr_accessor :controller_name



    def member_actions; @member_actions ||= {}; end

    # Looks up a resoruce by its model class.
    #
    # === Examples
    #
    #   AppKit::Resource.find(User)
    def self.find(model)
      if model.is_a? Symbol
        return AppKit.application.resources.find{|r|
          r.model.model_name.name.underscore.to_sym == model
        }
      end
      AppKit.application.resources.find{|r| r.model == model}
    end

    # A list of fields defined by the DSL
    attr_writer :fields
    def fields; @fields ||= []; end

    # A list of before_actions defined in the DSL. These actions
    # are executed in the controller before views are rendered. They
    # should be blocks which are given an instance of the model.
    #
    # This list should be managed from within the DSL and there should
    # be no need to add things to it directly. See AppKit::Action.
    attr_writer :before_actions
    def before_actions; @before_actions ||= {}; end

    # Initilization method
    #
    # === Attributes
    #
    # * +model+ - The model class this resource will manage.
    def initialize(model)
      @model = model
      AppKit.application.resources << self
      @navigation_position = :left
    end

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
      member_actions[name] = Action.new(name, self, options, &block)
    end

    # A DSL method for defining fields and their options.
    #
    # @param name [Symbol] the field name. This should relate to a method name on the model.
    # @param options [Hash] an optional hash to list field options. For a full list of field options see the AppKit::Field class.
    # @param block [Block] If a block is passed a DSL can be used to define the fields settings, instead of passing them in the options hash.
    # @example Define a new field
    #   field :name, editable: false, display_in_details: false
    def field(name, options={}, &block)
      field = Field.new(model, name, options)
      field.instance_eval(&block)  if block_given?
      fields << field
    end

    # Helper method for displaying the resource name.
    # @returns A human readable string for the given resource
    # @example A resource called against a UserOption model.
    #   resource.display_name #=> "User option"
    #
    def display_name
      model.name.demodulize.underscore.humanize
    end

    # Helper method for displaying the resource name.
    # @returns A human readable plural string for the given resource
    # @example A resource called against a UserOption model.
    #   resource.display_name #=> "User options"
    #
    def plural_display_name
      display_name.pluralize
    end

    # A list of the fields that should be displayed in tables.
    # All fields by default are included in this list, unless the
    # display_in_table option is set to false.
    # @return [array] An of Field objects with display_in_table set to true
    def table_fields
      fields.each.select(&:show_in_table)
    end

    # A list of fields that should be displayed in the #SHOW action or detail view
    # All fields are included in this list by default, unless the
    # display_in_detail option is set to false in the field options.
    def detail_fields
      fields.each.select(&:show_in_details)
    end

    # A list of all fields that can be displayed in the edit/create form. All fields
    # are included in this list unless the editable option in the field configuration is
    # set to false.
    def editable_fields
      fields.each.select(&:editable)
    end

    # A list of all has_many associations the model has.
    def has_many_associations
      model.reflect_on_all_associations.select{|a| a.macro == :has_many unless a.name == :versions }
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

    def actions_for_record?(record)
      member_actions.select{|name, a| a.enabled_for_record?(record)}.count > 0
    end

  end
end
