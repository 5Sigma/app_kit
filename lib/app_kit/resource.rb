module AppKit
    class Resource
        attr_writer :hidden_fields, :editors, :formatters, :actions
        attr_accessor :model, :controller_name 

        def editors; @editors ||= {}; end
        def formatters; @formatters ||= {}; end
        def hidden_fields; @hidden_fields ||= [:id, :created_at, :updated_at]; end
        def actions; @actions ||= []; end

        def initialize(model)
            @model = model
        end

        def is_hidden?(attribute_name)
            hiddne_fields.include? attribute_name
        end

        def hide(attributes)
            hidden_fields << attributes.to_s
        end

        def format_column(column, options)
            if options[:as] 
                self.formatters[column.to_sym] = options[:as]
            end
        end

        def show_in_navigation(val)
            if val == true 
                AppKit::Navigation::RESOURCES << self
            end
        end

        def edit(attribute, options)
            attribute = attribute.to_sym
            if options[:with]
                editors[attribute] = options[:with] 
            end
        end

        def visible_fields
            model.column_names.map(&:to_sym) - hidden_fields
        end
        def editable_attributes
            visible_fields.map{|i| i.to_sym}
        end
    end
end
