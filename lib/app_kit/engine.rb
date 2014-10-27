module AppKit
  class Engine < ::Rails::Engine
    load_path = File.expand_path('app/app_kit', Rails.root)

    isolate_namespace AppKit
    config.watchable_dirs[load_path]

  end

end
