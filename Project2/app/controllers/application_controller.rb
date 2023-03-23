class ApplicationController < ActionController::Base
    def after_sign_in_path_for(user)
        if user.admin_flag == true
            # admin path
        elsif user.instructor_flag == true
            # instructor path
        elsif user.student_flag == true
            # student path
        end
    end
end
