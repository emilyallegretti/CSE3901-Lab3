# frozen_string_literal: true

class GraderApplicationsController < ApplicationController
  before_action :find_app,
                only: %i[show edit update destroy]
                before_action :authenticate
                before_action :find_qualified_sections, only: %i[show]
  before_action :check_admin, only: %i[ update  ]

  # If admin, list the students that want to apply as a grader.
  # If student, list all of the applications belonging to student.
  def index
    if current_user.role == 'admin'
      @pagy, @applications = pagy(Application.where('is_accepted = ?', false))
      @pagy, @approved = pagy(Application.where('is_accepted = ?', true))
    elsif current_user.role == 'student'
      @pagy, @applications = pagy(Application.where('user_id = ?', current_user.id))
    end
  end

  # HTML form that allows students to create a new application.
  def new
    @application = Application.new
  end

  # Creates a new grader application.
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

        c = Course.find_by number: h['course_num']
        @qual = CourseQualification.new(application_id: id, course_id: c.id)
        @qual.save
      end
      # repeat for each course preference slot
      params[:course_preferences][:course_preferences].each do |h|
        # find the course id associated with this course num
        next unless h['course_num'].length.positive?

        c = Course.find_by number: h['course_num']
        @pref = CoursePreference.new(application_id: id, course_id: c.id)
        @pref.save
      end
      flash[:notice] = 'Application Successfully Created'
      redirect_to action: :index
    else
      flash[:notice] = 'Action Failed'
      render 'new'
    end
  end

  # Shows the contact info, availability, recommendations, and course preferences/qualifications of given student.
  def show
    # find any instructor recommendations that have been made for the student (for admin view only)
    @recs = Recommendation.where('student_email= ?', @application.user.email)
  end


  # Approves the application of given student.
  # Notifies if update was successful or not.
  def update
    @application = Application.find(params[:id])
    # Display an error message if the application can't be found.
    if @application.nil?
      flash.now[:notice] = 'Grader Application Not Found'
    # If the application was found, update their record in the database to mark them as approved.
    elsif @application.update(is_accepted: true)
      flash[:notice] = 'Grader Application Approved'
    # Display an error message if the approval failed when updating the database.
    else
      flash[:notice] = 'Failed to Approve Grader Application'
    end
    redirect_to action: :index
  end

  # Delete the application of given student.
  # Notifies if deletion was successful or not.
  def destroy
    if @application.destroy
      flash[:notice] = if current_user.role == 'admin'
                         'Grader Application Rejected'
                       else
                         'Grader Application Deleted'
                       end
    else
      flash[:error] = 'Failed to Remove Grader Application'
    end
    redirect_to action: :index
  end

  private
# This function will match an application to sections for the given term based on the app's availability and qualified courses.

  def find_qualified_sections
    # This array will hold all the sections the app is qualified for
    @qual_sections = Array.new
    # Find all courses for the application's term that match the application's term
    term_courses = Course.all.select{|c| c.term == @application.term }
    # Find all the term_courses whose course number matches the course number in course qualifications
    qual_courses = Array.new
    term_courses.each do |course|
      @application.course_qualification.each do |cq|
        qual_courses << course if course.number == cq.course.number
      end
    end

    qual_courses.each do |course|
      course.sections.each do |sec|
        # only match availabilities if this section is in need of graders, else continue to next iteration
         if sec.user_section.length == sec.num_graders_required
              next
        end
        # For each section of each course, first see if the section's days of the week match the days of week for which availabilities were filled out for
        # Strategy here: Collect an array of the section's days of the week and the available days of the week. If the arrays don't match, continue to next iteration of loop
        available_days = Array.new
        section_days = Array.new
        # if the section holds class on Monday, add it to section_days
        if sec.monday 
          section_days << "Monday"
          # if the section holds class on Monday and the application has availabilities listed on Monday, add it to available_days 
          if @application.availabilities.select{|a| a.day_of_week == "Monday"}.length > 0
            available_days << "Monday"
          end
        end
        # Repeat this logic for all other days of the school week
         if sec.tuesday 
          section_days << "Tuesday"
          if @application.availabilities.select{|a| a.day_of_week == "Tuesday"}.length > 0
            available_days << "Tuesday"
          end
        end
         if sec.wednesday 
          section_days << "Wednesday"
          if @application.availabilities.select{|a| a.day_of_week == "Wednesday"}.length > 0
            available_days << "Wednesday"
          end
        end
         if sec.thursday 
          section_days << "Thursday"
          if @application.availabilities.select{|a| a.day_of_week == "Thursday"}.length > 0
            available_days << "Thursday"
          end
        end
         if sec.friday 
          section_days << "Friday"
          if @application.availabilities.select{|a| a.day_of_week == "Friday"}.length > 0
            available_days << "Friday"
          end
        end
        # Check if the resulting available days array matches the days the section is offered. If not, continue to next iteration of loop
        if not(section_days == available_days)
          next
        end

        # Now for each day the section is offered, check the section's start and end time against all the available time slots for that day
        # If an open time slot is found for that day, add it to the list of matching days
        matching_days = Array.new
        available_days.each do |day|
          @application.availabilities.select{|a| a.day_of_week == day}.each do |avail|
            # if the availability start time is earlier than/equal to  the section start time, AND the availability end time is later than/equal to the 
            # section end time, we've found a matching time slot for that day; add it to the matching days array 
            if ((avail.start_time <=> sec.start_time) <= 0) && ((avail.end_time <=> sec.end_time) >= 0)
               # If a matching time slot has already been found for the current day, skip
               if not(matching_days.include? day)
                matching_days << day
               end
            end
          end
        end
        # Finally, check if we have found matching time slots for ALL days the section is offered by checking if matching_days equals section_days
        # if the two arrays match, add the section to @qual_sections
        if matching_days == section_days
          @qual_sections << sec
        end
      end
    end
  end
  def find_app
    @application = Application.find(params[:id])
  end

  # Clarify permitted parameters for each table.
  def app_params
    params.require(:application).permit(:term, :campus, :user_id, :availabilities)
  end

  def authenticate
    redirect_to '/' unless current_user
  end

  def check_admin
    redirect_to '/' unless current_user&.role == 'admin'
  end

end
