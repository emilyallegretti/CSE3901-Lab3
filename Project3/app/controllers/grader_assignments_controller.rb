# frozen_string_literal: true

class GraderAssignmentsController < ApplicationController
    before_action :authenticate
    def index
        @pagy, @grader_sections = pagy(Section.all)
    end

    private 
     def authenticate
    redirect_to "/" unless current_user&.role == "admin"
  end
end
