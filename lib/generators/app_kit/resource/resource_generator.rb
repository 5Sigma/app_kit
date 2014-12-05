class AppKit::ResourceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_resource_file
    begin
      @resource_class = Object.const_get(class_name)
      template "resource.rb", "app/app_kit/#{file_name}.rb"
    rescue NameError
      puts ""
      puts "The #{class_name} model doesn't exist."
      puts "AppKit resources are bound to models. You must first generate a model for the resource."
      puts ""
      puts "You can generate a model for this resource by running:"
      puts "rails g model #{class_name.underscore} column:string, column2:integer"
      return
    end

  end

end
