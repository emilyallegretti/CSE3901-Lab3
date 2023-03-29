class DashboardController < ApplicationController
    def load_in_database
        skip_before_action :verify_authenticity_token
        Parsing.get("col","1234") #params from view
        redirect_to courses_path
    end
    def reload_database
        Section.destroy_all
        Course.destroy_all      
        OsuClient.save_data_from_api
        redirect_to courses_path
    end    
    
end   