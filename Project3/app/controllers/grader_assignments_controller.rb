# frozen_string_literal: true

class GraderAssignmentsController < ApplicationController
    before_action :authenticate
    def index
      # get only the courses under the specified term
      if params[:term]
        @courses = Course.where("term=?", params[:term])
        @applications = Application.where("term = ?", params[:term])
      else 
        # if term isn't specified (i.e. on first visit to page), default to spring 2023 term
        @courses = Course.where("term = ?", "Spring 2023")
         @applications = Application.where("term = ?", "Spring 2023").and(Application.where("is_accepted = ?", true))
      end
        # build an array of sections from each course that still need a grader
        @grader_sections = Array.new
        @courses.each do |c|
          c.sections.each do |s|
            # if this section appears in the user_sections table less than the amount of graders required (meaning less graders
          #have been assigned than are needed), add this section to @grader_sections
            if s.user_section.length < s.num_graders_required
              @grader_sections << s
            end
          end
        end
        
    end
# When an admin assigns a grader to a section, this method will create a new row in sections_users associating the section and grader.
    def create
    end

    private 
     def authenticate
    redirect_to "/" unless current_user&.role == "admin"
  end
end
