require "bourbon"
require "neat"
require "font-awesome-sass"
require "simple_form"
require "font-awesome-sass";
require "jquery-rails";
require "ransack";

require "app_kit/engine"
require "app_kit/setup"
require "app_kit/dsl"

module AppKit
    autoload :Resource, 'app_kit/resource'
    autoload :Navigation, 'app_kit/navigation'
    autoload :Action, 'app_kit/action'
    autoload :Field, 'app_kit/field'
    LOAD_PATH = [File.expand_path('app/app_kit', Rails.root)]
end
