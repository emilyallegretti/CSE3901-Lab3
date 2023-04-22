# frozen_string_literal: true

# This controller handles all actions relating to course sections: editing, creating, deleting (which are
# admin only actions), viewing sections available for each course, and listing all the sections available to the specified course.

class SectionsController < ApplicationController
  before_action :authenticate
  before_action :check_admin, only: %i[create new update edit destroy]
  # first, find the course we are listing sections for
  before_action :find_course
  # for show, edit, update, and destroy, we are finding a specific section associated with the :id passed in the URL
  before_action :find_section, only: %i[show edit update destroy]

  # index will render views/sections/index.html.erb
  # this will list all of the sections listed for the specified @course
  # sections/index.html.erb will need access to @sections, which is a collection of all the sections associated with @course
  def index
    @pagy, @sections = pagy(@course.sections)
  end

  # create will POST a new section associated with the given course, creating a new row in the sections table and saving it to the database
  # after POST, we must redirect to a confirmation page from this method saying the section was successfully created
  def create
    @section = @course.sections.build(section_params)

    if @section.save
      flash[:notice] = 'Course Successfully Updated'
      redirect_to course_section_path(@course, @section)
    else
      flash.now[:notice] = 'Action Failed'
      render 'new'
    end
  end

  # new will render views/sections/new.html.erb
  # this will return a blank HTML form, having method POST for adding a new section. On submission of that form, "create" will be called.
  def new
    @section = @course.sections.build
  end

  # show will show a specific section and all of its information, if the user clicks on it.
  # find_section has already found the specific section for us
  def show
    return unless @section.nil?

    flash[:notice] = 'Action Failed'
    redirect_to action: :index
  end

  # edit will return a filled HTML form for the specified section so that the user can modify the fields. On submission of that
  # form, "update" will be called.
  # find_section has already found the specific section for us
  def edit; end

  # updates the record for the specified section in the database. This method is called after submission of an "edit section" form,
  # so that the database can be updated appropriately.
  def update
    if @section.update(section_params)
      flash[:notice] = 'Course Successfully Updated'
      redirect_to course_section_path(@course)
    else
      flash.now[:notice] = 'Action Failed'
      render :edit
    end
  end

  # destroys the record of the specified section, and returns to the section collection view.
  def destroy
    @section.destroy
    flash[:notice] = 'Course Successfully Updated'
    redirect_to action: :index
  end

  private

  # get the parent course for the sections we want to manipulate.
  def find_course
    @course = Course.find(params[:course_id])
  end

  def find_section
    @section = @course.sections.find(params[:id])
  end

  # sanitize inputs
  def section_params
    params.require(:section).permit(:num_graders_required, :section_number, :start_time, :end_time, :location, :monday,
                                    :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :mode_of_instruction)
  end

  def authenticate
    redirect_to '/' unless current_user
  end

  def check_admin
    redirect_to '/' unless current_user&.role == 'admin'
  end
end
