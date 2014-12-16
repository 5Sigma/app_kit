module AppKit::NavigationHelper
  def resource_navigation_link(resource)
    cls = ""
    if params[:controller] == "app_kit/#{resource.controller_name}"
      cls << "active "
    end
    link_to ak_path(resource.model), class: cls do
      if resource.navigation_icon
        concat icon(resource.navigation_icon, nil, class: 'fa-fw')
      end
      concat resource.plural_display_name
    end
  end

  def custom_navigation_link(item)
    cls = ""
    cls = "active" if params[:controller].to_s == item.controller.to_s
    link_to icon(item.icon,item.title), main_app.send("#{item.path_helper}_path"), class: cls
  end

  def navigation_link(item)
    if item.has_resource?
      resource_navigation_link(item.resource)
    else
      custom_navigation_link(item)
    end
  end

end
