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
    end
  end
end
