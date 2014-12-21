module AppKit::Dsl::ApplicationDsl
  # DSL method to set the application title. This is called from the
  # initializer.
  def title(title_text)
    config.application_title = title_text
  end

  # DSL method to disable user authentication. This is called from the
  # initializer
  def disable_authentication
    config.authentication_enabled = false
  end

  # DSL method for configuring the dashboard. This is called from the
  # initializer
  def dashboard(&block)
    AppKit.application.dashboard_view.instance_eval(&block)
  end

  # DSL method for creating custom naviation items. This is called from the
  # initializer
  def navigation_item(title, path_helper,options ={})
    nav_item = AppKit::NavigationItem.new
    nav_item.title = title
    nav_item.path_helper = path_helper
    nav_item.icon = options[:icon]
    nav_item.position = options[:position] || :left
    nav_item.controller = options[:controller]
    navigation_items << nav_item
  end
end
