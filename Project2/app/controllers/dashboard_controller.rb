class DashboardController < ApplicationController
    def load_in_database
        #OsuClient.save_data_from_api
        Parsing.get("col","1234")
        redirect_to courses_path
    end
    def reload_database
        Section.destroy_all
        Course.destroy_all      
        OsuClient.save_data_from_api
        redirect_to courses_path
    end    
    
end   