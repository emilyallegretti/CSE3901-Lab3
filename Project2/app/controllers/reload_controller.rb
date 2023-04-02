# This controller handles actions relating to reloading the database. It allows the admin to get the empty form where they specify 
# filters for reloading the database (if any), and trigger a reload of the database on submission of that form.
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
        # map the form parameters to their corresponding URL code 
        term_dictionary = {"All Terms"=>"","Spring 2023"=>"1232","Autumn 2023"=>"1238","Summer 2023"=>"1234"}
        n = tdictionary
        # if "all terms" was chosen, parse in data for each term
        if n==""
          Services::Parsing.load(cdictionary, term_dictionary["Spring 2023"])
          Services::Parsing.load(cdictionary, term_dictionary["Autumn 2023"])
          Services::Parsing.load(cdictionary, term_dictionary["Summer 2023"])
        else  
          # otherwise, only parse in data for the specified term
          Services::Parsing.load(cdictionary, tdictionary) #params from view
        end
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
      # In the API, selecting "All Campuses" defaults to Columbus campus
        campus_dictionary = {"All Campuses"=>"col","Columbus"=>"col","Lima"=> "lma","Mansfield" => "mns","Marion" => "MRN","Newark" => "nwk","Wooster" => "WST"}
        return campus_dictionary[params[:campus]]
    end
end