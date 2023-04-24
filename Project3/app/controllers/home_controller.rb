# frozen_string_literal: true

# This controller renders the user home page on signin. If the user is already signed in when the app is launched,
# this will be the root landing page.
class HomeController < ApplicationController
  # render the home page
  def index
    if current_user.role == "student"
    # see if there are any instructor recommendations associated with the current student
    @recs = Recommendation.where("student_email = ?", current_user.email)
    # see if there are applications associated with the current student
    @apps = Application.where("user_id = ?", current_user.id)
    end
  
  end
end
