module AppKit
    module AttributeHelper
        include FontAwesome::Sass::Rails::ViewHelpers

        def format_string(record, attribute, val)
            val
        end

        def format_currency(record,attribute,val)
            number_to_currency(val)
        end

        def format_date(record,attribute,val)
            val.strftime('%m/%d/%y')
        end

        def format_boolean(record, attribute, val)
            (val ? icon('toggle-on') : icon('toggle-off'))
        end
        
        def format_phone(record, attribute, val)
            number_to_phone(val)
        end

        def format_email(record, attribute, val)
            mail_to val
        end

        def format_datetime(record,attribute, val)
            val.strftime('%m/%d/%y %l:%m %p')
        end

        def format_attribute(record,field)
            formatter = field.formatter
            send("format_#{formatter}", record, field.name, record.send(field.name))
        end

        def detect_attribute_type(record,attribute)
            record.class.columns_hash[attribute.to_s].type || resource.formatters.has_key(attribute.to_sym)
        end

        def get_editor_for_attribute(attribute)
            resource.editors[attribute.to_sym]
        end
    end
end
