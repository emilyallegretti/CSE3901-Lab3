class DashboardController < ApplicationController
    skip_before_action :verify_authenticity_token
    def load_in_database
        Services::OsuClient.save_data_from_api
        redirect_to courses_path
    end    
    
end   