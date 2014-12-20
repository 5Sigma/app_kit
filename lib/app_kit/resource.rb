module AppKit
  # The resource class manages a model and contains most of the functionality for
  # dynamically interacting with the model. It also contains all the settings given
  # in the DSL.
  # The resource DSL is evaluated within this class.
  class Resource
    include AppKit::Dsl::ResourceDsl
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

    # A list of all fields that can be displayed in the filter panel.
    def filter_fields
      fields.each.select(&:show_in_filters)
    end

    # A list of all has_many associations the model has.
    def has_many_associations
      model.reflect_on_all_associations.select{|a| a.macro == :has_many unless a.name == :versions }
    end

    def actions_for_record?(record)
      member_actions.select{|name, a| a.enabled_for_record?(record)}.count > 0
    end

  end
end
