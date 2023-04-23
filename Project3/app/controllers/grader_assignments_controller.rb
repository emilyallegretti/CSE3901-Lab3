# frozen_string_literal: true

class GraderAssignmentsController < ApplicationController
  before_action :authenticate
  def index
    # get only the courses under the specified term
    # get only those applications that have been accepted and for the current term
    term = ''
    if params[:term]
      term = params[:term]
      @courses = Course.where('term=?', term)
    else
      # if term isn't specified (i.e. on first visit to page), default to spring 2023 term
      term = 'Spring 2023'
      @courses = Course.where('term = ?', term)
    end
    accepted_apps = Application.where('term = ? AND is_accepted = ?', term, true)

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
    @pagy, @applications = pagy_array(@applications)
    @pagy, @grader_sections = pagy_array(@grader_sections)
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

  private

  def authenticate
    redirect_to '/' unless current_user&.role == 'admin'
  end
end
