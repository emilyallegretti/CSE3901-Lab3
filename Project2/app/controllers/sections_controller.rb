# This controller handles all actions relating to course sections: editing, creating, deleting (which are 
# admin only actions), viewing sections available for each course, and listing all the sections available to the specified course.

class SectionsController < ApplicationController
    # for show, edit, update, and destroy, we are finding a specific section associated with the :id passed in the URL
     before_action :find_section, only [:show, :edit, :update, :destroy]

    # index will render views/sections/index.html.erb 
    # this will list all of the sections listed in the database
    # sections/index.html.erb will need access to @sections, which is a collection of all the sections in the database
    def index  
        @section = Section.all
    end 

    # create will POST a new section, creating a new row in the sections table and saving it to the database 
    # after POST, we must redirect to a confirmation page from this method saying the section was successfully created
    def create
        @section = Section.new(section_params)

        if @section.save
            redirect_to @section 
        else 
            render "new"
        end
    end

    # new will render views/sections/new.html.erb
    # this will return a blank HTML form, having method POST for adding a new section. On submission of that form, "create" will be called.
    # no code needed here, the HTML form with appropriate fields should be created in the View
    def new
    end

    # show will show a specific section and all of its information, if the user clicks on it. 
    # find_section has already found the specific section for us
    # TODO: do we need show?
    def show
         if @section.nil?
            #TODO: flash message?
            redirect_to action: :index
        end
    end

    # edit will return a filled HTML form for the specified section so that the user can modify the fields. On submission of that
    # form, "update" will be called.
    # find_section has already found the specific section for us
    def edit 
    end

    # updates the record for the specified section in the database. This method is called after submission of an "edit section" form,
    # so that the database can be updated appropriately. 
    def update
        if @section.update(section_params)
            redirect_to @section
        else 
            #TODO: flash message?
            render :edit 
        end
    end

    # destroys the record of the specified section, and returns to the section collection view.
    def destroy
        @section.destroy
        redirect_to action: :index
    end 


    private def find_section
            @section = Section.find(params[:id])
    end

    private def section_params
        params.require(:sections).permit( :num_graders_required, :section_number,:start_time,:end_time,:location,:monday,:tuesday , :wednesday ,:thursday ,:friday ,:saturday ,:sunday ,:mode_of_instruction )
    end
end
