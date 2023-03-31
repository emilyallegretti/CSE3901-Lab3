class DashboardController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    #return term number accociated with term name
    private def tdictionary      
        term_dictionary = {"All Terms"=>"","Spring 2023"=>"1232","Autumn 2023"=>"1238","Summer 2023"=>"1234"}
        return term_dictionary[params[:term]]       
    end
    
    #return abbreviation for campus name
    private def cdictionary
        campus_dictionary = {"All Campuses"=>"col","Columbus"=>"col","Lima"=> "lma","Mansfield" => "mns","Marion" => "MRN","Newark" => "nwk","Wooster" => "WST"}
        return campus_dictionary[params[:campus]]
    end

    #reload the database based on the term and campus parameters
    def reload_database
        Course.destroy_all
        Services::Parsing.load(cdictionary, tdictionary) 
        redirect_to courses_path
    end
end   