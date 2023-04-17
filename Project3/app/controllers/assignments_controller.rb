class AssignmentsController < ApplicationController
    # List the instructors and admins that are still pending admin approval.
    def index
        @graders = Application.all
    end

    # On approval of a user, change their "pending_approval " attribute to false and reload the requests page, and show a confirmation 
    # message.
    def update
      # find the user we are approving a request for
      @user = User.find(params[:id])
      # display an error message if the user can't be found
      if @user.nil?
        flash.now[:notice] = "Action failed"
        render :index
        # if the user was found, update their record in the database to mark them as approved
      elsif User.update(@user.id, :pending_approval => false)
        flash[:notice] = "Grader Assignment Successfully Approved"
        redirect_to action: :index
      else
        # display an error message if the approval failed when updating the database
        flash[:notice] = "Action failed"
        redirect_to action: :index
      end 
    end 
  end
