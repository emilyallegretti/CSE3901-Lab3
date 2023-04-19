class GraderApplicationsController < ApplicationController
  before_action :find_app, :find_availability, :find_preference, :find_qualification,
  only: [:show, :edit, :update, :destroy ]

  # List the students that want to apply as a grader.
  def index
    @pagy, @graders = pagy(Application.all)
  end

  def show
  end

  def edit
  end

  def update
  end

  # Delete the application of given student.
  def destroy
    if @grader.destroy
      flash[:notice] = "Grader Application Rejected"
      redirect_to action: :index
    else
      flash[:error] = "Failed to Reject Grader Application"
      redirect_to action: :edit
    end
  end

  # Functions to find attributes of given student application.
  private
  def find_app
    @grader = Application.find(params[:id])
  end

  def find_availability
    @availabilities = Availability.find(params[:id])
  end

  def find_preference
    @course_preferences = @grader.course_preference.find(params[:id])
  end

  def find_qualification
    @course_qualifications = @grader.course_qualification.find(params[:id])
  end

  # Clarify permitted parameters for each table.
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
