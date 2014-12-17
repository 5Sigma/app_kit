module AppKit
    # The field class manages individual attributes on a model.
    # == Fields DSL
    #
    # Fields are defined inside resource DSL. A field must have a name given by a symbol which relates to
    # a specific method on the model class and can take a variety of options to configure the way it is handled.
    #
    # === Field Options
    #
    # * +editable+ - If set to false a fieild will not be visible in the create/edit forms and it will not be whitelisted
    # * +formatter+ - A symbol for the fomatter to use when displaying this field.
    #   * +:currency+ - Formats using ActiveSupports number_to_currency method.
    #   * +:integer+ - Formats to humanized numbers.
    #   * +:date+ - Formats to +m/d/yy+ format
    #   * +:datetime+ - Formats to +m/d/yy+ hh:mm:ss
    #   * +:string+ - Returns the value unmodified.
    #   The default formatter for a given field is determened by its data type.
    # * +show_in_table+ - If set to false the field will not appear in tabular lists of the records.
    # * +show_in_detail+ - If set to false the field will not appear in the key/value details view in the #show action.
    # * +hide+ - A convienence method. If set to false the +display_in_table+, +display_in_detail+, and +editable+ options will all be set to false.
    # * +editor+ - The editor to use when this field is displayed on in the edit/create forms. The default editor is selected based on the field's data type.
    #
    # @example DSL inline options
    #   field :total_amount, :formatter => :currency, editable: false, display_in_table: false
    # @example DSL block options
    #   field :total_amount do
    #       formatter :currency
    #       editable false
    #       display_in_table false
    #   end
    class Field

        # A symbol which relates to the method on the model this field gets it's value from.
        attr_accessor :name
        # A boolean value indicating if this field is the foreign_key of an association
        attr_accessor :foreign_key
        # The data_type of this field. Retrieved from the column definition.
        attr_accessor :data_type
        # The association object for this field if it is a foreign_key
        attr_accessor :association
        # A custom field to sort by.
        attr_accessor :sort_field

        # DSL option for flagging the field as editable or not.
        # @param val [Boolean] if set to false the field will not be displayed in the edit/create form.
        attr_writer :editable
        def editable(val=nil)
            return @editable if val.nil?
            @editable = val
        end

        # DSL option for setting the formatting used for a field.
        # @param val [Symbol]
        attr_writer :formatter
        def formatter(val=nil)
            return @formatter if val.nil?
            @formatter = val
        end

        attr_writer :show_in_table
        # DSL option
        # @param val [Boolean] - If set to false the item will not appear in tables.
        def show_in_table(val = nil)
            return @show_in_table if val.nil?
            @show_in_table = val
        end


        attr_writer :show_in_details
        # DSL option
        # @param val [Boolean] - If set to false the field will not be displayed in the details panel of the #show action.
        def show_in_details(val=nil)
            return @show_in_details if val.nil?
            @show_in_details = val
        end

        # The display name for this field. By default it will be a humanized form of the method name.
        attr_writer :display_name
        def display_name; @display_name ||= name.to_s.humanize; end

        # DSL option - The editor to use when editing this field.
        attr_writer :editor
        def editor(val=nil)
            return @editor if val.nil?
            @editor = val
        end


        # This class is generally created by the Resource DSL and it should not need to be
        # created directly.
        # @param model [ActiveRecord::Base] The model this field belongs to.
        # @param name [Symbol] The method this field gets it's value from.
        # @param options [Hash] The options which should be set for this field.
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

        # Determins if the field is the foreign_key of an association.
        # @returns Boolean
        def is_foreign_key?
            association.present?
        end

        # Retrieves the assoicated record for this field. If it is a foreign_key.
        # @return An active record object on the otherside of the association.
        def associated_record
            assoication.active_record
        end

        # A conveinence method for completely hiding a field from the UI.
        # @param val [Boolean] If true the item will not be displayed in tables, details, and will not be editable.
        def hide(val = true)
            show_in_details !val
            show_in_table !val
            editable !val
        end

        # DSL method for setting the sort name for this field.
        # @param val [Symbol] The name of a column to sort this field by.
        def sort_field(val = nil)
            if val == nil
                @sort_field || name
            else
                @sort_field = val
            end
        end


    end
end
