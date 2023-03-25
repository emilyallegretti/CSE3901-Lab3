class DashboardController < ApplicationController
    def load_in_courses
        OsuClient.save_data_from_api
    end    
    def load_in_sections
        
    end
end   