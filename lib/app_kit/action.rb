module AppKit
    class Action
        attr_accessor :name, :block, :resource, :if_method

        def initialize(name, resource, options = {}, &block)
            @name = name
            @block = block if block_given?
            @resource = resource
            @if_method = options[:if]
        end

        def display_name 
            name
        end

        def enabled_for_record?(record)
            return true unless if_method
            true if record.send(if_method) 
        end

        def action_type
            (block.present? ? :block : :method_call)
        end

        def is_method_action?
            action_type == :method_call
        end

        def is_block_action?
            action_type == :block
        end

        def method_name
            name
        end

    end
end
