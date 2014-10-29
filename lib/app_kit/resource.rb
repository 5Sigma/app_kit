module AppKit
    # A collection of all active resources for the application. When a resource
    # is build by the DSL it is added to this list.
    RESOURCES=[]

    # The resource class manages a model and contains most of the functionality for
    # dynamically interacting with the model. It also contains all the settings given
    # in the DSL.
    # The resource DSL is evaluated within this class.
    class Resource
        attr_writer :hidden_fields, :editors, :formatters, :member_actions,
            :editable_fields
        attr_accessor :model, :controller_name

        def member_actions; @member_actions ||= {}; end

        # Looks up a resoruce by its model class. 
        #
        # === Examples
        #
        #   AppKit::Resource.find(User)
        def self.find(model)
            AppKit::RESOURCES.find{|r| r.model == model} 
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
        #
        # === Examples
        #
        #   AppKit::Resource.new(User)   
        def initialize(model)
            @model = model
            AppKit::RESOURCES << self
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
            model.name.underscore.humanize
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
        def detail_fields
            fields.each.select(&:show_in_details)
        end
        def editable_fields
            fields.each.select(&:editable)
        end
        
        def has_many_associations 
            model.reflect_on_all_associations.select{|a| a.macro == :has_many }
        end

        def show_in_navigation(val)
            if val == true 
                AppKit::Navigation::RESOURCES << self
            end
        end

        def before(action, &block)
            before_actions[action] = block
        end


    end
end
