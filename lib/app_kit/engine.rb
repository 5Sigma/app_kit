module AppKit
  class Engine < ::Rails::Engine
    load_path = File.expand_path('app/app_kit', Rails.root)
    isolate_namespace AppKit
    config.watchable_dirs[load_path]
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

  end

end
