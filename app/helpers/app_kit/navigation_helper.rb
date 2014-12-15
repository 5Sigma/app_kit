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

  def navigation_link(item)
    resource_navigation_link(item)
  end
end
