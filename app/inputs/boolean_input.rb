class BooleanInput < SimpleForm::Inputs::CollectionSelectInput
     def skip_include_blank?
         true
     end
end
