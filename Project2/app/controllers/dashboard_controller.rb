class DashboardController < ApplicationController
    skip_before_action :verify_authenticity_token

    def load_in_database
       
        Services::Parsing.load("col","1234") #params from view
        redirect_to courses_path
    end

    def reload_database
        Section.destroy_all
        Course.destroy_all      
        Services::Parsing.load(params[:campus], params[:term]) #params from view
        redirect_to courses_path
    end
end   