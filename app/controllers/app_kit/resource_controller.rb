module AppKit
    class ResourceController < ActionController::Base
        class_attribute :resource
        layout 'app_kit/application'

        before_action :find_record, only: [:show, :edit, :update, :destroy]

        def index
            @records = model.all
            render "app_kit/resources/index"
        end
        def new 
            @record = model.new
            render 'app_kit/resources/new'
        end

        def create
            @record = model.new(record_params)
            if @record.save
                redirect_to polymorphic_path([app_kit, @record]) 
            else
                render 'app_kit/resources/new'
            end
        end
        
        def show
            render 'app_kit/resources/show'
        end

        def edit
            render 'app_kit/resources/edit'
        end

        def update
            if @record.update(record_params)
                redirect_to polymorphic_path([app_kit, @record])
            else
                render 'app_kit/resources/edit'
            end
        end

        private
    
        def record_params
            params.require(model.name.underscore.to_sym).permit(resource.editable_attributes)
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
