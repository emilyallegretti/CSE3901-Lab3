class RequestsController < ApplicationController
  # List the instructors and admins that are still pending admin approval.
  def index
    @requests = User.where("pending_approval? = ? AND admin_flag = ?", true, true).or(User.where("pending_approval? = ? AND instructor_flag = ?", true, true))
  end

  # On approval of a user, change their "pending_approval? " attribute to false and reload the requests page. 
  def update
    @user = User.find(params[:id])
    if @user.update({'pending_approval': 'false'})
      redirect_to action: :index
    else 
     render :index
    end 
  end 
end
