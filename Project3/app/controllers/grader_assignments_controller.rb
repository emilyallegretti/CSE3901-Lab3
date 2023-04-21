# frozen_string_literal: true

class GraderAssignmentsController < ApplicationController
    def index
        @pagy, @grader_sections = pagy(Section.all)
    end
end
