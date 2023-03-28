class SectionsController < ApplicationController
    # for show, edit, update, and destroy, we are finding a specific course associated with the :id passed in the URL
    #before_action :find_course, only [:show, :edit, :update, :destroy]

   
    # index will render views/courses/index.html.erb 
    # this will list all of the courses listed in the database
    # courses/index.html.erb will need access to @courses, which is a collection of all the courses in the database
    def index  
        @section = Section.all
        
    end 

    # create will POST a new course, creating a new row in the Courses table and saving it to the database 
    # after POST, we must redirect to a confirmation page from this method saying the course was successfully created
    def create
        @section = Section.new(section_params)

        if @section.save
            redirect_to @section 
        else 
            render "new"
        end
    end

    # new will render views/courses/new.html.erb
    # this will return a blank HTML form, having method POST for adding a new course. On submission of that form, "create" will be called.
    # no code needed here, the HTML form with appropriate fields should be created in the View
    def new
    end

    # show will show a specific course and all of its information, if the user clicks on it. 
    # find_course has already found the specific course for us
    #TODO: do we need show?
    def show
         if @section.nil?
            #TODO: flash message?
            redirect_to action: :index
        end
    end

    # edit will return a filled HTML form for the specified student so that the user can modify the fields. On submission of that
    # form, "update" will be called.
     # find_course has already found the specific course for us
    def edit 
    end

    # updates the record for the specified course in the database. This method is called after submission of an "edit course" form,
    # so that the database can be updated appropriately. 
    def update
        

        if @section.update(section_params)
            redirect_to @section
        else 
            #TODO: flash message?
            render :edit 
        end
    end

    # destroys the record of the specified course, and returns to the course collection view.
    def destroy
        @section.destroy
        redirect_to action: :index
    end 

    # reload will scrape the API for course data on CSE courses, clear the database if it is not already empty, and re-populate
    # the database with the results of the web scraping. This will need to be the first function called by the first admin
    # in order to initially populate the database.
    def reload

        # after reload, redirect to the index page that will list all the courses in the database
        redirect_to action: :index

    end


    private def find_section
            @section = Section.find(params[:id])
    end

    private def section_params
        params.require(:sections).permit( :num_graders_required, :section_number,:start_time,:end_time,:location,:monday,:tuesday , :wednesday ,:thursday ,:friday ,:saturday ,:sunday ,:mode_of_instruction )
    end
    
     
end