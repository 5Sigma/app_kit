module AppKit
  def self.register(model, &block)
    # create resource controller
    return unless ActiveRecord::Base.connection.table_exists? model.table_name
    resource_name = model.name.demodulize.underscore.pluralize
    controller_name = model.name.demodulize.pluralize
    controller = AppKit.const_set("#{controller_name}Controller",
                                  Class.new(ResourcesController))
    controller.resource = Resource.new(model)
    controller.resource.instance_exec(&block)  if block_given?
    controller.resource.controller_name = controller.controller_name
    controller.prepend_view_path("app/views/#{model.name.underscore.pluralize}")
    # draw controller routes
    AppKit::Engine.routes.append do
      resources resource_name.to_sym do
        controller.resource.has_many_associations.each do |assoc|
          resources assoc.name.to_s.pluralize, only: [:new]
        end
        member do
          get 'history' => :history, :as => :history
          get 'version/:version_id' => :version, :as => :version
          controller.resource.member_actions.each do |name,action|
            get action.name, action: 'perform_action', action_name: 'deactivate'
          end
        end
        collection do
          get 'versions/:version_id' => :show_version, :as => :show_version
        end
      end
    end
  end
  def self.setup(&block)
    @@application = Application.new
    AppKit.application.setup!
    AppKit.application.instance_exec(&block)
  end
end
