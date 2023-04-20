# frozen_string_literal: true

class GraderApplicationsController < ApplicationController
  before_action :find_app,
                only: %i[show edit update destroy]

  # If admin, list the students that want to apply as a grader.
  # If student, list all of the applications belonging to student.
  def index
    if current_user.role == 'admin'
      @pagy, @applications = pagy(Application.all)
    elsif current_user.role == 'student'
      @pagy, @applications = pagy(Application.where('user_id = ?', current_user.id))
    end
  end

  # HTML form that allows students to create a new application.
  def new
    @application = Application.new
  end

  def create
    # Create the new application using the app params.
    @application = Application.new(app_params)
    if @application.save
      # if app saved successfully, get its id to associate each new availability, course qual, and course pref with it
      id = @application.id
      # for each availability slot filled out, create a new row in Availabilities table associated with this application
      params[:availabilities][:availabilities].each do |h|
        next unless h['start_time'].length.positive? || h['end_time'].length.positive?

        @availability = Availability.new(application_id: id, start_time: h['start_time'], end_time: h['end_time'],
                                         day_of_week: h['day_of_week'])
        @availability.save
      end
      # repeat for each course qualification slot
      params[:course_qualifications][:course_qualifications].each do |h|
        # first, find the course id associated with this course num
        next unless h['course_num'].length.positive?

        c_id = Course.find_by number: h['course_num']
        @qual = CourseQualification.new(application_id: id, course_id: c_id)
        @qual.save
      end
      # repeat for each course preference slot
      params[:course_preferences][:course_preferences].each do |h|
        # find the course id associated with this course num
        next unless h['course_num'].length.positive?

        c_id = Course.find_by number: h['course_num']
        @qual = CourseQualification.new(application_id: id, course_id: c_id)
        @qual.save
      end
      flash[:notice] = 'Application Successfully Created'
      redirect_to action: :index
    else
      flash[:notice] = 'Action Failed'
      render 'new'
    end
  end

  # Shows the contact info, availability, and course preferences/qualifications of given student.
  def show; end

  # HTML form that allows admins to edit student applications.
  def edit; end

  # Update the application of given student.
  # Notifies if update was successful or not.
  def update
    if @application.update(app_params) & @application.availabilities.update(availability_params) & @application.course_preference.update(preference_params) & @application.course_qualification.update(qualification_params)
      flash[:notice] = 'Grader Application Updated'
      redirect_to action: :show
    else
      flash.now[:notice] = 'Update Failed'
      redirect_to action: :edit
    end
  end

  # Delete the application of given student.
  # Notifies if deletion was successful or not.
  def destroy
    if @application.destroy
      flash[:notice] = 'Grader Application Rejected'
    else
      flash[:error] = 'Failed to Reject Grader Application'
    end
    redirect_to action: :index
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
