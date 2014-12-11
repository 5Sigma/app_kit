class AppKit::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  include Rails::Generators::Migration

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def copy_initializer
    copy_file "app_kit.rb", "config/initializers/app_kit.rb"
  end

  def create_user_migration
    migration_template "create_users.rb", "db/migrate/create_app_kit_users.rb"
  end

  def install_simple_form
    generate "simple_form:install"
  end

  def create_routes
    route 'mount AppKit::Engine => "/"'
  end

end
