class AppKit::FilterFormBuilder < ActionView::Helpers::FormBuilder

  def filter_params
    @template.params[param_set.to_sym].try(:first)
  end

  def param_set
    "#{@object_name.underscore}_filter"
  end
  def get_field_name(field, tag="value")
    "#{param_set}[][#{field.name}][#{tag}]"
  end
  def label(field)
    css = ""
    if filter_params
      if filter_params[field.name]["value"].present?
        css << " highlight"
      end
    end
    @template.label param_set, field.name, field.display_name, class: css
  end
  def search_input(field)
    value = filter_params[field.name]["value"] rescue nil
    @template.search_field_tag get_field_name(field), value
  end

  def predicate_select(field)
    select_options_array = case field.data_type
                           when :integer, :decimal
                             [
                               ['equals', 'eq'],
                               ['greater than','gt'],
                               ['less than', 'lt'],
                               ['not equal', 'nq']
                             ]
                           else
                             [
                               ['contains', 'cont'],
                               ['doesn\'t contain', 'ncont']
                             ]
                           end
    @template.select_tag get_field_name(field, 'condition'),
      @template.options_for_select(select_options_array)
  end


  def filter_field(field)
    case field.data_type
    when :date, :datetime
      @template.content_tag :div, class: 'range-filter date-range' do
        @template.search_field_tag(get_field_name(field,'from'), nil, placeholder: 'from') +
          @template.search_field_tag(get_field_name(field,'to'), nil, placeholder: 'to')
      end
    when :boolean
      value = filter_params[field.name]["value"] rescue nil
      options = @template.options_for_select([['Any', ''],['Yes', 'true'], ['No', 'false']], value)
      @template.select_tag get_field_name(field, 'value'), options
    when :integer
      if field.is_foreign_key?
        @template.collection_select get_field_name(field), nil,
          field.association.klass.all, :id, :to_s,
          prompt: 'Any'
      else
        predicate_filter(field)
      end
    else
      predicate_filter(field)
    end
  end

  def filter(field)
    label(field) + filter_field(field)
  end


  def predicate_filter(field)
    @template.content_tag :div, class: 'predicate-filter' do
      @template.content_tag(:div, predicate_select(field), class: 'predicate-select') +
        @template.content_tag(:div, search_input(field), class: 'value')
    end
  end
end
