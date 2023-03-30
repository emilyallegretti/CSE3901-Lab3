class CoursesController < ApplicationController
    # skip authentication; we already have verified the type of user logged in
    skip_before_action :verify_authenticity_token
    # for show, edit, update, and destroy, we are finding a specific course associated with the :id passed in the URL
    before_action :find_course, only: [:show, :edit, :update, :destroy]


    # index will render views/courses/index.html.erb 
    # this will list all of the courses listed in the database
    # courses/index.html.erb will need access to @courses, which is a collection of all the courses in the database
    def index  
        @courses = Course.all
        # Render a specific view of courses based on the type of user signed in (since admins/instructors have different permissions)
        if current_user.role == "admin"
            render template: "courses/admin_index"
        elsif current_user.role == "instructor"
            render template: "courses/instructor_index"
        else
            render template: "courses/student_index"
        end
    end 

    # create will POST a new course, creating a new row in the Courses table and saving it to the database 
    # after POST, we must redirect to a confirmation page from this method saying the course was successfully created
    def create
        @course = Course.new(course_params)

        if @course.save
            flash[:notice] = "Course Successfully Updated"
            redirect_to @course
        else 
            flash.now[:notice] = "Action Failed"
            render "new"
        end
    end

    # new will render views/courses/new.html.erb
    # this will return a blank HTML form, having method POST for adding a new course. On submission of that form, "create" will be called.
    #create new @course instance for html form
    def new
        @course = Course.new
    end

    # show will show a specific course and all of its information, if the user clicks on it. 
    # find_course has already found the specific course for us
    #TODO: do we need show?
    def show
        render template: "courses/course_index"
         if @course.nil?
            #TODO: flash message?
            flash[:notice] = "Action Failed"
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
        if @course.update(course_params)
            flash[:notice] = "Course Successfully Updated"
            redirect_to course_path(@course)
        else 
            flash.now[:notice] = "Action Failed"
            render :edit
        end
    end

    # destroys the record of the specified course, and returns to the course collection view.
    def destroy
        @course.destroy
        flash[:notice] = "Course Successfully Updated"
        redirect_to action: :index
    end

    # find the course with :id
    private def find_course
            @course = Course.find(params[:id])
    end

    # sanitize inputs
    private def course_params
        params.require(:course).permit(:name, :number,:term,:campus)
    end
    
   
end
