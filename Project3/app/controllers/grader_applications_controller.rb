class GraderApplicationsController < ApplicationController
  before_action :find_app,
  only: [:show, :edit, :update, :destroy ]

  # If admin, list the students that want to apply as a grader.
  # If student, list all of the applications belonging to student.
  def index
    if current_user.role == "admin"
      @pagy, @applications = pagy(Application.all)
    elsif current_user.role == "student"
      @pagy, @applications = pagy(Application.where("user_id = ?", current_user.id))
    end
  end

  # HTML form that allows students to create a new application.
  def new
    @application = Application.new 
  end

  def create
    @application = Application.new(params[:application][:term])
    if @application.save
      id = @application.id
      @availability = Availability.new(availability_params)
      @course_preference = Course_preference.new(preference_params)
      @course_qualification = Course_qualification.new(qualification_params)
      flash[:notice] = "Application Successfully Created"
      redirect_to @application
    else 
      flash[:notice] = "Action Failed"
      render "new"
    end
  end

  # Shows the contact info, availability, and course preferences/qualifications of given student.
  def show
  end

  # HTML form that allows admins to edit student applications.
  def edit
  end

  # Update the application of given student.
  # Notifies if update was successful or not.
  def update
    if @application.update(app_params) & @availabilities.update(availability_params) & @course_preferences.update(preference_params) & @course_qualifications.update(qualification_params)
      flash[:notice] = "Grader Application Updated"
      redirect_to action: :show
    else 
      flash.now[:notice] = "Update Failed"
      redirect_to action: :edit
    end
  end

  # Delete the application of given student.
  # Notifies if deletion was successful or not.
  def destroy
    if @application.destroy
      flash[:notice] = "Grader Application Rejected"
      redirect_to action: :index
    else
      flash[:error] = "Failed to Reject Grader Application"
      redirect_to action: :index
    end
  end

  # Functions to find attributes of given student application.
  private
  def find_app
      @application = Application.find(params[:id])
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
