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
            model.reflect_on_all_associations.select{|a| a.macro == :has_many }.map(&:name)
        end

        def show_in_navigation(val)
            if val == true 
                AppKit::Navigation::RESOURCES << self
            end
        end


    end
end
