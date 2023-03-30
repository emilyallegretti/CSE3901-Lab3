class HomeController < ApplicationController
  # Displays the correct layout depending on user role
  # (admin, instructor, student).
  def index
    if current_user.role == "admin"
      render template: "layouts/admin"
    elsif current_user.role == "instructor"
      render template: "layouts/instructor"
    else
      render template: "layouts/student"
    end
  end
end
