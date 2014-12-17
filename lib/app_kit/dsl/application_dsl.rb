module AppKit::Dsl::ApplicationDsl
  def title(title_text)
    config.application_title = title_text
  end
  def disable_authentication
    config.authentication_enabled = false
  end
  def dashboard(&block)
    dashboard.instance_eval(&block)
  end
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
