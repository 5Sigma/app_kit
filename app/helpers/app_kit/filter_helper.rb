module AppKit::FilterHelper

  # create form fields for side bar filtering.
  # @param search_form [Ransack::SearchForm] The search form object.
  # @param field [AppKit::Field] The field to create filters for.
  # @param The search instance from ransack (usually %q)
  def filter_field(search_form, field, search_instance)
    case field.data_type
    when :boolean
      search_form.select "#{field.name}_eq",
        boolean_select_options, prompt: 'Any'
    when :datetime
      content_tag :div, class: 'range-filter' do
        concat search_form.search_field("#{field.name}_lt")
        concat search_form.search_field("#{field.name}_gt")
      end
    when :string
      predicate = get_field_predicate(search_instance,field,'cont')
      options = string_predicate_options(search_instance, field)
      predicate_select = select_tag("#{field.name}_predicate",options)
      search_field = filter_search_field(search_form, field, predicate)
      content_tag :div, class: 'predicate-filter' do
        concat content_tag(:div, predicate_select, class: 'predicate-select')
        concat content_tag(:div, search_field, class: 'value')
      end
    when :integer, :decimal
      if field.is_foreign_key?
        search_form.collection_select field.name,
          field.association.klass.all, :id, :to_s,
          prompt: 'Any'
      else
        predicate = get_field_predicate(search_instance, field, 'eq')
        options = number_predicate_options(search_instance, field)
        predicate_select = select_tag("#{field.name}_predicate",options)
        search_field = filter_search_field(search_form, field, predicate)
        content_tag :div, class: 'predicate-filter' do
          concat content_tag(:div, predicate_select, class: 'predicate-select')
          concat content_tag(:div, search_field, class: 'value')
        end
      end
    else
      predicate = get_field_predicate(search_instance,field,'cont')
      options = string_predicate_options(search_instance, field)
      predicate_select = select_tag("#{field.name}_predicate",options)
      search_field = filter_search_field(search_form, field, predicate)
      content_tag :div, class: 'predicate-filter' do
        concat content_tag(:div, predicate_select, class: 'predicate-select')
        concat content_tag(:div, search_field, class: 'value')
      end
    end
  end

  # Returns select options for boolean filters
  def boolean_select_options(val=nil)
    options_for_select([['Yes', 1], ['No', 0]], val)
  end

  # Get current search instance predicate or return default value.
  # @param search_instance [Ransack Search Instance] usually %q.
  # @param field [AppKit::Field] field to check.
  # @param default [String] the default value if none is found.
  def get_field_predicate(search_instance,field,default)
    condition = search_instance.conditions.find {|i|
      i.attributes.first.name = field.name.to_s
    }
    return default unless condition
    return condition.predicate.name
  end

  # Condition select options for string based fields.
  # @param search_instance [Ransack Search Instance] usually %q
  # @param field [AppKit::Field] the field to generate a filter for.
  def string_predicate_options(search_instance, field)
    predicate = get_field_predicate(search_instance,field,'cont')
    options = [['contains', 'cont'],["doesn't contain", 'not_cont']]
    options_for_select(options,predicate)
  end

  # Condition select options for number based fields.
  # @param search_instance [Ransack Search Instance] usually %q
  # @param field [AppKit::Field] the field to generate a filter for.
  def number_predicate_options(search_instance,field)
    predicate = get_field_predicate(search_instance,field,'eq')
    options = [
      ['equals', 'eq'],["not equal", 'not_eq'],
      ['greater than', 'gt'], ['less than', 'lt']
    ]
    options_for_select(options,predicate)
  end

  # Creates the search field for filters.
  # @params search_form ransack form builder
  # @param field [AppKit::Field] the field to generate a filter for.
  # @param predicate [String] the predicate condition.
  def filter_search_field(search_form, field, predicate)
    search_method = "#{field.name}_#{predicate}"
    search_form.search_field search_method.to_sym,
      "data-field" => field.name.to_s
  end

end
