class DashboardController < ApplicationController
    def load_in_database
        Services::OsuClient.save_data_from_api
        redirect_to courses_path
    end    
    
end   