class DashboardController < ApplicationController
    def load_in_database
        OsuClient.save_data_from_api
        redirect_to courses_path
    end    
    
end   