class RequestsController < ApplicationController
 
    
  # List the instructors and admins that are still pending admin approval.
  def index
    @requests = User.where("pending_approval = ? AND role = ?", true, "instructor").or(User.where("pending_approval = ? AND role = ?", true, "admin"))
  end

  # On approval of a user, change their "pending_approval " attribute to false and reload the requests page. 
  def update
    @user = User.find(params[:id])
    if @user.nil?
      render :index
    elsif User.update(@user.id, :pending_approval => false)
      flash[:notice] = "User Request Successfully Approved"
      redirect_to action: :index
    else 
      flash[:notice] = "Action failed"
      redirect_to action: :index
    end 
  end 
end
