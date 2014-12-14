$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "app_kit/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "app_kit"
  s.version     = AppKit::VERSION
  s.authors     = ["Joe Bellus"]
  s.email       = ["joe@5sigma.io"]
  s.homepage    = "http://appkit.5sigma.io"
  s.summary     = "A data driven application framework."
  s.description = "AppKit provides a full framework for rapidly creating data driven application through a simple DSL."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.6"
  s.add_dependency "jquery-rails"
  s.add_dependency "sass-rails", "~> 4.0.3"
  s.add_dependency "bourbon"
  s.add_dependency "font-awesome-sass"
  s.add_dependency "neat"
  s.add_dependency "simple_form"
  s.add_dependency "coffee-rails"
  s.add_dependency "kaminari"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency "devise"
  s.add_dependency "as_csv"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "faker"
  s.add_development_dependency "yard"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'paper_trail'

  s.test_files = Dir["spec/**/*"]

end
