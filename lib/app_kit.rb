require "bourbon"
require "neat"
require "font-awesome-sass"
require "simple_form"
require "font-awesome-sass"
require "jquery-rails"
require "jquery-ui-rails"
require "kaminari"
require "devise"
require "as_csv"
require "app_kit/kaminari_patch"
require "slim-rails"
require "paper_trail"

require "app_kit/dsl"

module AppKit
    LOAD_PATH = [File.expand_path('app/app_kit', Rails.root)]

    autoload :Application, 'app_kit/application'
    autoload :Configuration, 'app_kit/configuration'
    autoload :Resource, 'app_kit/resource'
    autoload :NavigationItem, 'app_kit/navigation_item'
    autoload :Action, 'app_kit/action'
    autoload :Field, 'app_kit/field'
    autoload :FilterFormBuilder, 'app_kit/filter_form_builder'

    module Views
      autoload :Base, 'app_kit/views/base'
      autoload :Dashboard, 'app_kit/views/dashboard'
      autoload :Table, 'app_kit/views/table'
    end

    module Dsl
      autoload :ResourceDsl, 'app_kit/dsl/resource_dsl'
      autoload :ApplicationDsl, 'app_kit/dsl/application_dsl'
    end

    def self.application
      @@application
    end
end
require "app_kit/engine"
