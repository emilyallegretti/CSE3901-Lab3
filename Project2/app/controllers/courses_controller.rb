# This controller handles all actions relating to courses: editing, creating, deleting (which are 
# admin only actions), viewing courses, and listing all the courses
# in the database.

class CoursesController < ApplicationController
    # skip authentication; we already have verified the type of user logged in
    skip_before_action :verify_authenticity_token
    # for show, edit, update, and destroy, we are finding a specific course associated with the :id passed in the URL
    before_action :find_course, only: [:show, :edit, :update, :destroy]

    # index will render views/courses/index.html.erb 
    # this will list all of the courses listed in the database
    # courses/index.html.erb will need access to @courses, which is a collection of all the courses in the database
    def index  
            if params[:commit] == nil || params[:commit] == "Clear Search"
                @pagy, @courses = pagy(Course.all)   
            else
                @pagy, @courses = pagy(Course.where("number LIKE ?", "%" + params[:search] + "%").or(Course.where("name LIKE ?", "%" + params[:search] + "%")).or(
                    Course.where("campus LIKE ?", "%" + params[:search] + "%")).or(Course.where("term LIKE ?", "%" + params[:search] + "%")))
            end    
    end

    # create will POST a new course, creating a new row in the Courses table and saving it to the database 
    # after POST, we must redirect to the new course's "show" method, with a flash message the course was successfully created
    def create
        # create a new course with the params passed in from the input form
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
    def new
         # create new @course instance for html form
        @course = Course.new
    end

    # show will show a specific course and all of its information, if the user clicks on it. 
    # find_course has already found the specific course for us
    def show
        # display an error message if the course can't be found
        if @course.nil?
            flash[:notice] = "Action Failed"
            redirect_to action: :index
        end
    end

    # edit will return a filled HTML form for the specified course so that the user can modify the fields. On submission of that
    # form, "update" will be called.
     # find_course has already found the specific course for us
    def edit 
    end

    # updates the record for the specified course in the database. This method is called after submission of an "edit course" form,
    # so that the database can be updated appropriately. 
    def update
        # attempt to update the course's record in the database using the params passed in from the "edit" form
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
        # display a success message
        flash[:notice] = "Course Successfully Updated"
        redirect_to action: :index
    end 

    # find the course with given :id from the URL
    private def find_course
        @course = Course.find(params[:id])
    end

    # sanitize inputs passed in from the input forms
    private def course_params
        params.require(:course).permit(:name, :number,:term,:campus)
    end   
end
