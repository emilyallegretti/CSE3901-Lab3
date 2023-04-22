# frozen_string_literal: true

# This controller handles actions relating to Pending Approval requests from admins and instructors who have just signed up.
# It allows the admin to view the list of users who are pending approval from another admin, and it updates
# the user's record in the database upon admin approval.
class RequestsController < ApplicationController
  before_action :authenticate
  # List the instructors and admins that are still pending admin approval.
  def index
    @requests = User.where('pending_approval = ? AND role = ?', true,
                           'instructor').or(User.where('pending_approval = ? AND role = ?', true, 'admin'))
  end

  # On approval of a user, change their "pending_approval " attribute to false and reload the requests page, and show a confirmation
  # message.
  def update
    # find the user we are approving a request for
    @user = User.find(params[:id])
    # display an error message if the user can't be found
    if @user.nil?
      flash.now[:notice] = 'Action failed'
      render :index
      # if the user was found, update their record in the database to mark them as approved
    elsif User.update(@user.id, pending_approval: false)
      flash[:notice] = 'User Request Successfully Approved'
      redirect_to action: :index
    else
      # display an error message if the approval failed when updating the database
      flash[:notice] = 'Action failed'
      redirect_to action: :index
    end
  end

  private

  def authenticate
    redirect_to '/' unless current_user&.role == 'admin'
  end
end
