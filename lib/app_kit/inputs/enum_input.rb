class EnumInput < SimpleForm::Inputs::CollectionSelectInput
  def input(wrapper_options = nil)
    collection = options[:enum]
    label_method = :last
    value_method = :first
    merged_input_options = merge_wrapper_options(input_html_options,
                                                 wrapper_options)
    @builder.collection_select(
      attribute_name, collection, value_method, label_method,
      input_options, merged_input_options
    )
  end
end
