class ApplicationController < ActionController::Base
    # include Pagy in all controllers.
    include Pagy::Backend

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    # Add our custom user attributes to the devise sanitizer.
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :role, :pending_approval, :email])
    end
end
