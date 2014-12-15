class AppKit::Views::Table
  attr_accessor :resource, :resource_scope, :page, :filter_enabled
  attr_writer :title

  def initialize(resource, options = {})
    resource = AppKit::Resource.find(resource) if resource.is_a? Symbol
    @resource = resource
    @resource_scope = options[:resource_scope]
    @title = options[:title]
    @records = options[:records]
    @page = options[:page] || 1
    @filter_enabled = (options[:filter].nil? ? true : false) 
  end

  def icon
    resource.navigation_icon || 'list'
  end

  def title
     @title || resource.plural_display_name
  end

  def records
    unless @records
      @records = @resource.model
      @records = @records.send(resource_scope) if resource_scope
      @records.page(page)
    end
    @records.page(page)
  end


end
