module AppKit
    class ResourcesController < ActionController::Base
        class_attribute :resource
        layout 'app_kit/application'

        before_action :find_record, only: [:show, :edit, :update, :destroy]

        def index
            @records = model.all
        end

        def new 
            @record = model.new
            resource.before_actions[:new].call(@record) if resource.before_actions[:new] 
        end

        def create
            @record = model.new(record_params)
            resource.before_actions[:create].call(@record) if resource.before_actions[:create] 
            if @record.save
                redirect_to polymorphic_path([app_kit, @record]) 
            else
                render 'new'
            end
        end
        
        def show
            resource.before_actions[:show].call(@record) if resource.before_actions[:show] 
        end

        def edit
            resource.before_actions[:edit].call(@record) if resource.before_actions[:edit] 
        end

        def update
            resource.before_actions[:update].call(@record) if resource.before_actions[:update] 
            if @record.update(record_params)
                redirect_to polymorphic_path([app_kit, @record])
            else
                render 'edit'
            end
        end

        def perform_action
            find_record
            action_name = params[:action_name].to_sym
            action = resource.member_actions[action_name]
            if action.is_method_action?
                @record.send(action.method_name)
            end
            if action.is_block_action?
                action.block.call(@record)
            end
            return redirect_to([app_kit, @record])
        end

        private
    
        def record_params
            params.require(model.name.underscore.to_sym).permit(resource.editable_fields.map(&:name))
        end

        def find_record
            @record ||= model.find_by_id(params[:id])
        end

        def resource
            self.class.resource
        end
        helper_method :resource

        def model 
            @model ||= Object.const_get(controller_name.classify)
        end
        helper_method :model

        def resource_name
            controller_name.humanize
        end
        helper_method :resource_name

        def displayable_attributes
            self.class.resource.visible_fields
        end
        helper_method :displayable_attributes
        

    end
end
