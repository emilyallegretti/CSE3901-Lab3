# frozen_string_literal: true

# This controller handles the admin action associated with viewing all the course sections that have the required amount of graders assigned.
# It backs an index view, which lists all the course sections meeting the assigned grader requirements.
class AssignedSectionsController < ApplicationController
  before_action :authenticate

  def index
    term = ''
    # get only the courses under the specified term
    if params[:term]
      term = params[:term]
      @courses = Course.where('term=?', term)
    else
      # if term isn't specified (i.e. on first visit to page), default to spring 2023 term
      term = 'Spring 2023'
      @courses = Course.where('term = ?', term)
    end

    # build an array of sections from each course that have enough graders assigned
    @sections = []
    @courses.each do |c|
      c.sections.each do |s|
        # if this section appears in the user_sections table the same amount of times as the amount of graders required (meaning the section
        # has had all the required amount of graders assigned), add the section to @sections
        @sections << s if s.user_section.length == s.num_graders_required
      end
    end
    @pagy, @grader_sections = pagy_array(@sections)
  end

  private

  def authenticate
    # if a non-admin or someone who isnt signed in tries to navigate to any URL associated with this controller, redirect them back to home page
    def authenticate
      redirect_to '/' unless current_user&.role == 'admin'
    end
  end
end
