class AppKit::NavigationItem
  attr_accessor :resource, :title, :path_helper, :position, :controller
  attr_writer :icon

  def initialize
    @position = :left
  end

  def get_path
    if has_resource?
      polymorphic_path([app_kit, resource])
    else
      main_app.send(path_helper)
    end
  end

  def icon
    if has_resource?
      resource.navigation_icon
    else
      @icon
    end
  end

  def has_resource?
    resource != nil
  end
end
