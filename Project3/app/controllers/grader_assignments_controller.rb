# frozen_string_literal: true
# This controller handles all actions related to admins assigning grader applications to sections. It renders an "index" view that shows all
# course sections for the specified term that still need graders assigned, along with all grader applications that haven't been assigned to a 
# section yet. From this page, the admin is able to assign graders to sections.
# This controller also supports a "create" method that creates a new row in sections_users when a grader is assigned to an application.
class GraderAssignmentsController < ApplicationController
    before_action :authenticate
    def index
      # get only the courses under the specified term
      # get only those applications that have been approved and for the current term
      term = ""
      if params[:term]
        term = params[:term]
        @courses = Course.where("term=?", term)
        accepted_apps = Application.where("term = ? AND is_accepted = ?", term, true)
      else 
        # if term isn't specified (i.e. on first visit to page), default to spring 2023 term
        term = "Spring 2023"
        @courses = Course.where("term = ?", term)
        accepted_apps = Application.where("term = ? AND is_accepted = ?", term, true)
      end

    # now get the applications that have not been assigned to a section yet (i.e. the associated user isn't in user_section table)
    @applications = []
    # only add an accepted app to @applications if its associated user id is not already in user_section for the given term
    accepted_apps.each do |a|
      @applications << a if a.user.user_section.select { |us| us.section.course.term == term }.empty?
    end

    # build an array of sections from each course that still need a grader
    @grader_sections = []
    @courses.each do |c|
      c.sections.each do |s|
        # if this section appears in the user_sections table less than the amount of graders required (meaning less graders
        # have been assigned than are needed), add this section to @grader_sections
        @grader_sections << s if s.user_section.length < s.num_graders_required
      end
    end
    @pagy_apps, @applications = pagy_array(@applications)
    @pagy_graders, @grader_sections = pagy_array(@grader_sections)
  end

  # When an admin assigns a grader to a section, this method will create a new row in sections_users associating the section and grader.
  def create
    # find the user id associated with the email passed in from params
    @user = User.find_by(email: params[:email])
    @user_section = UserSection.new(user_id: @user.id, section_id: params[:section_id])
    flash[:notice] = if @user_section.save
                       'Grader Successfully Assigned To Section'
                     else
                       'Error Assigning Grader To Section. Please try again.'
                     end
    redirect_to action: :index
  end

  def destroy
  end

  private
# if a non-admin or someone who isnt signed in tries to navigate to any URL associated with this controller, redirect them back to home page
  def authenticate
    redirect_to '/' unless current_user&.role == 'admin'
  end
end
