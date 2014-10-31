$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "app_kit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "app_kit"
  s.version     = AppKit::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of AppKit."
  s.description = "TODO: Description of AppKit."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.6"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails"
  s.add_dependency "bourbon"
  s.add_dependency "font-awesome-sass"
  s.add_dependency "neat"
  s.add_dependency "simple_form"
  s.add_dependency "coffee-rails"
  s.add_dependency "ransack"
  s.add_dependency "ransack"
  s.add_dependency "kaminari"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "faker"
end
