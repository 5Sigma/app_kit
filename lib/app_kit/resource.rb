module AppKit
    class Resource
        attr_writer :hidden_fields, :editors, :formatters, :member_actions,
            :editable_fields
        attr_accessor :model, :controller_name

        def member_actions; @member_actions ||= {}; end

        attr_reader :fields
        def fields; @fields ||= []; end 

        def initialize(model)
            @model = model
        end

        def action(name, options={}, &block)
            member_actions[name] = Action.new(name, self, options, &block)
        end

        def field(name, options={}, &block) 
            field = Field.new(model, name, options)
            field.instance_eval(&block)  if block_given?
            fields << field 
        end

        def show_in_navigation(val)
            if val == true 
                AppKit::Navigation::RESOURCES << self
            end
        end


    end
end
