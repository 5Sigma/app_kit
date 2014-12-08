class AppKit::Views::Table
  attr_accessor :resource, :resource_scope
  attr_writer :title

  def initialize(resource, options = {})
    resource = AppKit::Resource.find(resource) if resource.is_a? Symbol
    @resource = resource
    @resource_scope = options[:resource_scope]
    @title = options[:title]
  end

  def title
     @title || resource.plural_display_name
  end

  def get_records
    records = @resource.model
    records = records.send(resource_scope) if resource_scope
    records.page(0)
  end
end
