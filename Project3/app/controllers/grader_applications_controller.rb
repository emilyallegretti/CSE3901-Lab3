class GraderApplicationsController < ApplicationController
  before_action :find_app, :find_availability, :find_preference, :find_qualification,
  only: [:edit, :update ]

  # List the instructors and admins that are still pending admin approval.
  def index
    @pagy, @graders = pagy(Application.all)
  end

  def edit
  end 

  # On approval of a user, change their "pending_approval " attribute to false and reload the requests page, and show a confirmation 
  # message.
  def update
  end

  #functions to find application info given user_id
  private
  def find_app
    # get all the applications associated with the current user's id
    @applications = Application.where("user_id = ?", current_user.id)
  end

  def find_availability
    @availabilities = Availability.find(params[:application_id])
  end

  def find_preference
    @course_preferences = Course_preference.find([:application_id])
  end

  def find_qualification
    @course_qualifications = Course_qualification.find(params[:application_id])
  end

  #param functions
  def app_params
    params.require(:application).permit(:term, :campus, :user_id, :availabilities)
  end   
  
  def availability_params
    params.require(:application).permit(:availabilities)
  end    

  def preference_params
    params.require(:course_preference).permit(:application_id, :course_id)
  end    

  def qualification_params
    params.require(:course_qualification).permit(:application_id, :course_id)
  end
end
