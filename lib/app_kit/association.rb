class AppKit::Association
  attr_accessor :owner_model
  attr_accessor :associated_model
  attr_accessor :display_name
  attr_accessor :association_type
  attr_accessor :association
  attr_accessor :association_name
  attr_accessor :foreign_key

  def initialize(assoc)
    @foreign_key = assoc.foreign_key
    @association_type = assoc.macro
    @association_name = assoc.name
    @owner_model = assoc.active_record
    @associated_model = assoc.klass
  end

  def relation
    @owner_model.send(@association_name)
  end

  def plural_display_name
    display_name.pluralize
  end

end
