module AppKit
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
            files = LOAD_PATH.flatten.compact.uniq.map{ |path| Dir["#{path}/**/*.rb"] }.flatten
            files.each { |file| load file }
        end
    end
end
