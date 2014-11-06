module AppKit
    module AttributeHelper
        include FontAwesome::Sass::Rails::ViewHelpers

        # General helpers for dealing with field columns

        def format_string(record, attribute, val)
            val
        end

        def format_currency(record,attribute,val)
          number_to_currency(val) || "$0.00"
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

        def format_integer(record, attribute, val)
            number_to_human(val)
        end

        def format_decimal(record,attribute, val)
            number_to_human(val)
        end

        def format_datetime(record,attribute, val)
            val.strftime('%m/%d/%y %l:%m %p')
        end

        def format_attribute(record,field)
            if field.is_foreign_key?
                associated_record = record.send(field.association.name)
                return link_to associated_record, [app_kit, associated_record]
            end
            formatter = field.formatter
            format_method = "format_#{formatter}"
            return send(format_method, record, field.name, record.send(field.name)) if self.respond_to?(format_method)
            return record.send(field.name)

        end

        def detect_attribute_type(record,attribute)
            record.class.columns_hash[attribute.to_s].type || resource.formatters.has_key(attribute.to_sym)
        end

        def get_editor_for_attribute(attribute)
            resource.editors[attribute.to_sym]
        end
    end
end
