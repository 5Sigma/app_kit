module AppKit
    # The action class is used to generate custom actions that can be performed on a given record.
    # These actions are displayed when viewing a specific record.
    # Actions are defiend in the main Resource DSL.
    #
    #
    # == DSL Examples
    # === Inline example
    #   action :deactivate, :if => :active
    #   
    # === Block example
    #
    #   action :deactivate, :if => :active do |record|
    #       record.update(active: false)
    #   end
    class Action
        # The name of the aciton. This will be used to display the link title of the action itself.
        # It will also be used as a the name of the method on the model class to execute if a block is 
        # not given.
        #
        #   action :consolidate_items 
        #
        # This action would create a custom action visible when viewing a resource record. This action will
        # also execute a method named +consolidate_items+ on the model instance.
        attr_accessor :name

        # The block to be executed when the aciton is performed.
        #   action :deactive do |record|
        #      record.update(active: false)
        #   end 
        attr_accessor :block

        # The resoruce this action belongs to.
        attr_accessor :resource

        # A method to call on the model to determin if this action should be displayed.
        #   action :deactivate, :if => :active
        attr_accessor :if_method
    

        # This class should be created from the Resource DSL and should not be created manually.
        # @param name [Symbol] The name of the action and the name of the model method to call (if no block is given).
        # @param resource [AppKit::Resource] The resource this action belongs to.
        # @param options [Hash] A optin hash for the action.A
        # @parma &block [Block] A block to execute when the action is performed. This block is passed a model instance.
        def initialize(name, resource, options = {}, &block)
            @name = name
            @block = block if block_given?
            @resource = resource
            @if_method = options[:if]
        end
    
        # The display name to use when displaying a link to the action.
        # @return [String] A humanized version fo the name.
        def display_name 
            name.humanize
        end
        
        # Determines if the action should be displayed
        # @param record [Model] A model instance to test.
        # @return [Boolean] Returns true if the if_method returns true or is not defined.
        def enabled_for_record?(record)
            return true unless if_method
            true if record.send(if_method) 
        end
    
        # Determines if the action should call to a method or execute a block.
        # @return [Symbol] Returns either +:block+ or +:method_call+
        def action_type
            (block.present? ? :block : :method_call)
        end
    
        # Convienence method that detmines if the action should call a model method. 
        def is_method_action?
            action_type == :method_call
        end
    
        # Convienence method that detmines if the action should call a block. 
        def is_block_action?
            action_type == :block
        end
        
        # The method name to call on the model.
        # @return [Symbol] Returns the name of the action.
        def method_name
            name
        end

    end
end
