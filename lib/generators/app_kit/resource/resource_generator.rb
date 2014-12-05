class AppKit::ResourceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_resource_file
    unless Object.const_defined?(class_name)
      puts "the #{class_name} model doesn't exist. Generate it first"
      return
    end
    @resource_class = Object.const_get(class_name)
    template "resource.rb", "app/app_kit/#{file_name}.rb"

  end

end
