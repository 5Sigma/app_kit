class AppKit::Application
  include AppKit::Dsl::ApplicationDsl
  attr_accessor :dashboard_view
  attr_accessor :config
  attr_accessor :resources
  attr_writer :navigation_items

  def initialize
    @config = AppKit::Configuration.new
    @resources = []
    @navigation_items = []
    @dashboard_view = AppKit::Views::Dashboard.new
  end

  def navigation_items(position = :all)
    return @navigation_items if position == :all
    navigation_items.select { |i| i.position == position }
  end

  def setup!(&block)
    AppKit::LOAD_PATH.each do |path|
      AppKit::Engine.config.watchable_dirs[path] = [:rb]
    end
    # setup load paths
    ActiveSupport::Dependencies.autoload_paths -= AppKit::LOAD_PATH
    Rails.application.config.eager_load_paths  -= AppKit::LOAD_PATH

    # reload the rails routes after initialization has completed.
    Rails.application.config.after_initialize do
      ActionDispatch::Reloader.to_prepare do
        Rails.application.reload_routes!
      end

      # load DSL files
      files = AppKit::LOAD_PATH.flatten.compact.uniq.map{ |path| Dir["#{path}/**/*.rb"] }.flatten
      files.each { |file| load file }

      # process application dsl
      AppKit.application.instance_exec(&block)
      if config.authentication_enabled?
        require "app_kit/user_resource"
        AppKit::ApplicationController.class_eval("before_filter :authenticate_user!")
      end
    end
  end
end
