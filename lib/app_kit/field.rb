module AppKit
    class Field
        attr_accessor :name, :foreign_key, :data_type, :association

        attr_writer :editable
        def editable(val=nil)
            return @editable unless val
            @editable = val
        end
        
        attr_writer :formatter
        def formatter(val=nil)
            return @formatter unless val
            @formatter = val
        end

        attr_writer :show_in_table
        def show_in_table(val = nil)
            return @show_in_table if val.nil?
            @show_in_table = val
        end

        attr_writer :show_in_details 
        def show_in_details(val=nil)
            return @show_in_details if val.nil?
            @show_in_details = val
        end

        attr_writer :display_name 
        def display_name; @display_name ||= name.to_s.humanize; end

        def show_in_details (val=nil)
            return @show_in_details if val.nil?
            @show_in_details = val
        end

        attr_writer :editor
        def editor(val=nil)
            return @editor if val.nil?
            @editor = val
        end

                 

        def initialize(model, name, options={})
            @name = name
            @data_type = model.columns_hash[name.to_s].try(:type) || :string
            @show_in_details = true
            @show_in_table = true
            @editable = true
            @formatter = data_type
            options.each {|k,v| send(k,v) }

            @association = model.reflect_on_all_associations.find{|i| i.foreign_key.to_sym == name}
        end

        def is_foreign_key?
            association.present?
        end

        def associated_record
            assoication.active_record
        end

        def hide(val = true)
            show_in_details = !val
            show_in_table = !val
            editable = !val
        end

        
    end
end
