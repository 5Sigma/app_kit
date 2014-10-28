module AppKit
    class Field
        attr_accessor :name, :foreign_key, :association_name, :data_type

        attr_writer :editable
        def editable(val=nil)
            @editable ||= true
            return @editable unless val
            @editable = val
        end
        
        attr_writer :formatter
        def formatter(val=nil)
            @formatter ||= data_type
            return @formatter unless val
            @formatter = val
        end

        attr_writer :show_in_table
        def show_in_table(val = nil)
            @show_in_table ||= true
            return @show_in_table unless val
            @show_in_table = val
        end

        attr_writer :show_in_details 
        def show_in_details; @show_in_details ||= true; end

        attr_writer :display_name 
        def display_name; @display_name ||= name.to_s.humanize; end

    

        def initialize(model, name, options={})
            @name = name
            @data_type = model.columns_hash[name.to_s].try(:type) || :string

            options.each do |k,v| 
                send(k,v)
            end
        end

        def hide
            show_in_details = false
            show_in_table = false
            editable = false
        end

        
    end
end
