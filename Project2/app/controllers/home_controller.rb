class HomeController < ApplicationController
  def index
    if current_user.admin_flag
      render template: "layouts/admin"
    elsif current_user.instructor_flag
      render template: "layouts/instructor"
    else
      render template: "layouts/student"
    end
  end
end
