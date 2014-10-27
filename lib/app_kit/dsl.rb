module AppKit
    def self.register(model, &block)
        # create resource controller
        resource_name = model.name.underscore.pluralize
        controller_name = model.name.pluralize
        controller = AppKit.const_set("#{controller_name}Controller", Class.new(ResourceController))
        controller.resource = Resource.new(model)
        controller.resource.instance_exec(&block)  if block_given?
        controller.resource.controller_name = controller.controller_name
        AppKit::Engine.routes.prepend do
            resources resource_name.to_sym 
        end
    end
end
