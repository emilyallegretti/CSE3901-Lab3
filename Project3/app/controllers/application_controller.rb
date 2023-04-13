class ApplicationController < ActionController::Base
    # include Pagy in all controllers.
    include Pagy::Backend

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :find_app, :find_availability, :find_preference, :find_qualification, only: [:show, :edit, :update]

    protected
    # Add our custom user attributes to the devise sanitizer.
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :role, :pending_approval, :email])
    end

    #display a new HTML form for submitting an application    
    def new
    end        

    #function called when form is submitted for grader applications
    #updates the database with the info from the application they filled out
    def new
        @application = Application.new(app_params)
        @availability = Availability.new(availability_params)
        @course_preference = Course_preference.new(preference_params)
        @course_qualification = Course_qualification.new(qualification_params)      
    end    

    #function to display info from a previously submitted app
    #find functions already have data
    def show
    end    

    #function to show a filled out HTML form when a user wants to edit their appliation
    #update will be called on submit
    #find functions already have data
    def edit
    end    

    #function called to update grader application
    def update
        #use separate boolean values for readability instead of one long if statement
        boolean app_success = @appliation.update(app_params)
        boolean avail_success = @availability.update(availability_params)
        boolean pref_success = @course_preference.update(preference_params)
        boolean qualif_success = @course_qualification.update(qualification_params)

        #alert user of success if all updates worked
        if app_success && avail_success && pref_success && qualif_success
            flash[:notice] = "Application Updated"
            #add redirect
        else 
            flash.now[:notice] = "Update Failed"
            #add redirect
        end
    end    

    #function to remove application info from the database
    def destroy
        @appliation.destroy
        @availability.destroy
        @course_preference.destroy
        @course_qualification.destroy
        flash[:notice] = "Application deleted"
        #add redirect

    #functions to find application info given user_id
    private def find_app
        @application = Application.find(params[:user_id])
    end

    private def find_availability
        @availability = Availability.find(params[:user_id])
    end

    private def find_preference
        @course_preference = Course_preference.find([:user_id])
    end

    private def find_qualification
        @course_qualification = Course_qualification.find(params[:user_id])
    end

    #param functions
    private def app_params
        params.require(:application).permit(:user_id)
    end   
    
    private def availability_params
        params.require(:availability).permit(:application_id)
    end    

    private def preference_params
        params.require(:course_preference).permit(:application_id, :course_id)
    end    

    private def qualification_params
        params.require(:course_qualification).permit(:application_id, :course_id)
    end

end
