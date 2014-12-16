module AppKit
  # Setup the appkit instance including reloading routes and modifying the
  # load paths. The AppKit DSL needs to be removed from the load paths because
  # we dont it loading before the models.
  def self.setup(&block)
    LOAD_PATH.each do |path|
      AppKit::Engine.config.watchable_dirs[path] = [:rb]
    end
    ActiveSupport::Dependencies.autoload_paths -= LOAD_PATH
    Rails.application.config.eager_load_paths  -= LOAD_PATH
    Rails.application.config.after_initialize do
      ActionDispatch::Reloader.to_prepare do
        Rails.application.reload_routes!
      end
      # load DSL files
      files = LOAD_PATH.flatten.compact.uniq.map{ |path| Dir["#{path}/**/*.rb"] }.flatten
      files.each { |file| load file }
      AppKit.application.dashboard = AppKit::Views::Dashboard.new
      AppKit::SetupDsl.module_eval(&block)
      if application.config.authentication_enabled?
        require "app_kit/user_resource"
        ApplicationController.class_eval("before_filter :authenticate_user!")
      end
    end

    def self.application
      @@application
    end
  end

  module SetupDsl
    def self.title(title_text)
      AppKit.application.config.application_title = title_text
    end
    def self.disable_authentication
      AppKit.application.config.authentication_enabled = false
    end
    def self.dashboard(&block)
      AppKit.application.dashboard.instance_eval(&block)
    end
    def self.navigation_item(title, path_helper, icon=nil)
      nav_item = AppKit::NavigationItem.new
      nav_item.title = title
      nav_item.path_helper = path_helper
      nav_item.icon = icon
      AppKit.application.navigation_items << nav_item
    end
  end
end
