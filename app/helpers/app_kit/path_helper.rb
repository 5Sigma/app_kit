module AppKit::PathHelper
  # Convienence method for using AppKit path helpers. This method uses
  # polymorphic_paths and prepends the AppKit route object.
  # @params path [Array,Object] a polymorphic path option.
  def ak_path(path)
    if path.is_a? Array
      path.prepend app_kit
    else
      path = [app_kit, path]
    end
    polymorphic_path(path)
  end
end
