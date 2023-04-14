 class ApplicationsController < ApplicationController
 before_action :find_app, #:find_availability, :find_preference, :find_qualification
  only: [:show, :edit, :update, ]

 #display a new HTML form for submitting an application    
    def new
        # create an empty application object for bootstrap form 
        @application = Application.new 
    end 
     # display an "application dashboard" associated with a specific student user. This view is where all actions
     # associated with a student's grader application will reside. 
     #IF the student does not have an application associated with them, this view will present them the option to start a new application.
     # IF the student does have an application associated with them, this view will list their active application, and give them the option
     # to show, edit, or delete the app.
    def dashboard
        @applications = find_app
    end

    #function called when form is submitted for grader applications
    #updates the database with the info from the application they filled out
    def create
        @application = Application.new(params[:application][:term])
        if @application.save
            id = @application.id
                @availability = Availability.new(availability_params)
        end
        #@course_preference = Course_preference.new(preference_params)
        #@course_qualification = Course_qualification.new(qualification_params)      
       if @application.save
            flash[:notice] = "Application Successfully Created"
            redirect_to @application
        else 
            flash[:notice] = "Action Failed"
            render "new"
        end
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
        boolean app_success = @application.update(current_user.id, app_params)
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
        @application = Application.find(params[:id])
        @application.destroy
       # @availability.destroy
        #@course_preference.destroy
        #@course_qualification.destroy
        flash[:notice] = "Application deleted"
        #add redirect
        redirect_to "/dashboard", allow_other_host: :true
    end

    #functions to find application info given user_id
    private def find_app
        # get all the applications associated with the current user's id
        @applications = Application.where("user_id = ?", current_user.id)
    end



   # private def find_availability
    #    @availabilities = Availability.find(params[:application_id])
    #end

    #private def find_preference
     #   @course_preferences = Course_preference.find([:application_id])
    #end

    #private def find_qualification
     #   @course_qualifications = Course_qualification.find(params[:application_id])
    #end

    #param functions
    private def app_params
        params.require(:application).permit(:term, :campus, :user_id, :availabilities)
    end   
    
    private def availability_params
        params.require(:application).permit(:availabilities)
    end    

    private def preference_params
        params.require(:course_preference).permit(:application_id, :course_id)
    end    

    private def qualification_params
        params.require(:course_qualification).permit(:application_id, :course_id)
    end
end