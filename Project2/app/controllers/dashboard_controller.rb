class DashboardController < ApplicationController
    layout "admin"
    before_action :authenticate_user!
       
    
    def index
        @courses = Course.all
        @sections = Section.all
    end
    
    def load_in_database
        
        skip_before_action :verify_authenticity_token
        Services::Parsing.load("col","1234") #params from view
        redirect_to courses_path
    end
    def reload_database
        Section.destroy_all
        Course.destroy_all      
        Services::Parsing.load("col","1234") #params from view
        redirect_to courses_path
    end    
    
end   