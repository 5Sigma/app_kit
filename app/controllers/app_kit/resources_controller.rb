module AppKit
    # The base resource controller. This controller contains all the functionality for REST
    # actions for all resources. Resource specific controllers are generated that inherit from
    # this class. It should not be nessicary to use this class directly.
    class ResourcesController < ActionController::Base
        class_attribute :resource
        layout 'app_kit/application'

        before_action :find_record, only: [:show, :edit, :update, :destroy, :perform_action]
        

        # GET /resource
        # Lists all records for an invoice.
        def index
            @q = model.search(params[:q])
            @records = @q.result
        end
        
        # GET /resource/new
        # Renders new form for a given resource.
        def new 
            @record = model.new
            # call before actions created in the DSL 
            resource.before_actions[:new].call(@record) if resource.before_actions[:new] 
        end
    
        # POST /resource
        # Creates a new resource record if valid, renders new form if not.
        def create
            @record = model.new(record_params)
            # call before actions created in the DSL
            resource.before_actions[:create].call(@record) if resource.before_actions[:create] 
            if @record.save
                redirect_to polymorphic_path([app_kit, @record]) 
            else
                render 'new'
            end
        end
       

        # GET /resource/:id 
        # Shows the details of a given resource.
        def show
            resource.before_actions[:show].call(@record) if resource.before_actions[:show] 
        end


        # GET /resource/:id/edit
        # Shows the edit form for a given resource.
        def edit
            resource.before_actions[:edit].call(@record) if resource.before_actions[:edit] 
        end
        

        # PATCH /resource/:id
        # Updates a given resource if valid, renders the edit form if not.
        def update
            flash[:success] = "Record updated successfully."
            # call before actions created in the DSL
            resource.before_actions[:update].call(@record) if resource.before_actions[:update] 
            if @record.update(record_params)
                redirect_to polymorphic_path([app_kit, @record])
            else
                render 'edit'
            end
        end
       

        # DELETE /resource/:id
        # Deletes a given resource and redirects to index.
        def destroy 
            if @record.destroy
                flash[:success] = "Record deleted successfully."
                redirect_to polymorphic_path([app_kit, model])
            end
        end


        # GET /resource/:id/:action_name
        # A catchall action for any custom actions defined in the DSL.
        # The action name is passed by the route as a param and a block 
        # given in the DSL is called (with the record instance).
        #
        # Actions can be defined using blocks are a symbol name of a method
        # in the model.
        def perform_action
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
    
        # Whitelisting for all fields marked as +editable+ in the dsl. 
        def record_params
            params.require(model.name.underscore.to_sym).permit(resource.editable_fields.map(&:name))
        end

        # A generic before_action method to set an instance variable for the 
        # current record.
        def find_record
            @record ||= model.find_by_id(params[:id])
        end
        
        # A helper method that returns the AppKit::Resource object tied to the current controller.
        def resource
            self.class.resource
        end
        helper_method :resource
        
        # A helper method to retrieve the model classs based on the current controller's
        # class name.
        def model 
            @model ||= Object.const_get(controller_name.classify)
        end
        helper_method :model
        
        # A helper method to display the current resource name.
        def resource_name
            controller_name.humanize
        end
        helper_method :resource_name
        
        

    end
end
