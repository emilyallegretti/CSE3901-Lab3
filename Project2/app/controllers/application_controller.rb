class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(user)
        if user.admin_flag == true
            # admin path
        elsif user.instructor_flag == true
            # instructor path
        elsif user.student_flag == true
            # student path
        end
    end
    
    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :role, :pending_approval?, :email])
    end



end
