# frozen_string_literal: true

class ApplicationsController < ApplicationController
  before_action :find_app, :find_availability, :find_preference, :find_qualification,
                only: %i[show edit update]

  # display a new HTML form for submitting an application
  def new
    # create an empty application object for bootstrap form
    @application = Application.new
  end

  # display an "application dashboard" associated with a specific student user. This view is where all actions
  # associated with a student's grader application will reside.
  # IF the student does not have an application associated with them, this view will present them the option to start a new application.
  # IF the student does have an application associated with them, this view will list their active application, and give them the option
  # to show, edit, or delete the app.
  def dashboard
    @applications = Application.where('user_id = ?', current_user.id)
  end

  # function called when form is submitted for grader applications
  # updates the database with the info from the application they filled out
  def create
    # first create the new application using the app params
    @application = Application.new(app_params)
    if @application.save
      # if app saved successfully, get its id to associate each new availability, course qual, and course pref with it
      id = @application.id
      # for each availability slot filled out, create a new row in Availabilities table associated with this application
      params[:availabilities][:availabilities].each do |h|
        next unless h['start_time'].length.positive? || h['end_time'].length.positive?

        @availability = Availability.new(application_id: id, start_time: h['start_time'],
                                         end_time: h['end_time'], day_of_week: h['day_of_week'])
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
      redirect_to action: :dashboard
    else
      flash[:notice] = 'Action Failed'
      render 'new'
    end
  end

  # function to display info from a previously submitted app
  # find functions already have data
  def show; end

  # function to show a filled out HTML form when a user wants to edit their appliation
  # update will be called on submit
  # find functions already have data
  def edit; end

  # function called to update grader application
  def update
    # use separate boolean values for readability instead of one long if statement
    boolean app_success = @application.update(current_user.id, app_params)
    boolean avail_success = @availability.update(availability_params)
    boolean pref_success = @course_preference.update(preference_params)
    boolean qualif_success = @course_qualification.update(qualification_params)

    # alert user of success if all updates worked
    if app_success && avail_success && pref_success && qualif_success
      flash[:notice] = 'Application Updated'
    # add redirect
    else
      flash.now[:notice] = 'Update Failed'
      # add redirect
    end
  end

  # function to remove application info from the database
  def destroy
    @application = Application.find(params[:id])
    @application.destroy
    flash[:notice] = 'Application deleted'
    redirect_to action: :dashboard
  end

  # functions to find application/availability/preference/qualification info given the application id
  private

  def find_app
    @application = Application.find(params[:id])
  end

  def find_availability
    @availabilities = Availability.where('application_id = ?', params[:id])
  end

  def find_preference
    @course_preferences = CoursePreference.where('application_id = ?', params[:id])
  end

  def find_qualification
    @course_qualifications = CourseQualification.where('application_id = ?', params[:id])
  end

  # param functions
  def app_params
    params.require(:application).permit(:term, :campus, :user_id, :is_accepted)
  end
end
