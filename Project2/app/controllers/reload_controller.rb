class ReloadController < ApplicationController

  skip_before_action :verify_authenticity_token
    
  # get an HTML form for inputting filters on the reload
  def new
  end
    

# use the params passed from the "new" form to parse in the specified data from the database
    def reload_database
      # if there are courses in the database already, clear them out
        Course.destroy_all
        # parse the API
        Services::Parsing.load(cdictionary, tdictionary) #params from view
        #redirect to the newly populated course catalog
        redirect_to courses_path
    end

    # these helper functions map the values passed in from the reload form to its corresponding parameter used in the API URL.
    private def tdictionary
      #Map the term filter to its query code
        term_dictionary = {"All Terms"=>"","Spring 2023"=>"1232","Autumn 2023"=>"1238","Summer 2023"=>"1234"}
        return term_dictionary[params[:term]]    
    end
    private def cdictionary
      #map the campus filter to its query abbreviation
        campus_dictionary = {"All Campuses"=>"col","Columbus"=>"col","Lima"=> "lma","Mansfield" => "mns","Marion" => "MRN","Newark" => "nwk","Wooster" => "WST"}
        return campus_dictionary[params[:campus]]
    end
end