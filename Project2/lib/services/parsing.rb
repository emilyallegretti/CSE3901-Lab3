
module Services
    # This is the class that performs the web scraping of the course catalog API. It uses the HTTParty gem to get course and section
    # data from the API in JSON format, using query parameters passed in from the "Reload Database" view form. 

    # The "Reload Database" view form allows the admin to choose which campus and semester(s) for which to load in courses/sections
    # for. The self.load method will use these filters to scrape only the specified course data in.
    class Parsing
        include HTTParty
        # Base URL that we are querying.
        base_uri "https://content.osu.edu/v2/classes/search"
        # Default parameters in the URL that we are querying.
        default_params q: "cse", client: "class-search-ui", p: "1" 
        format :json

        # This method loads in courses and sections data from the API documentation
        # campus_q: the campus to load in, as specified in the HTML form
        # term_q: the term(s) to load in, as specified in the HTML form 
        def self.load (campus_q, term_q)
            # get the JSON response using the query data
            @pars_resp = get("",{ query: {campus: campus_q, term: term_q} })["data"]["courses"]
        
            # For each course object received in the JSON response, create a row in the Course table in our database, and parse in that course's data
            @pars_resp.each do |k|
          
                c = Course.create(name: k["course"]["title"],number: k["course"]["catalogNumber"],term: k["course"]["term"],campus: k["course"]["campus"])

                # Get the section data associated with this course
                sec= k["sections"]
          
                # For each section object associated with this course, create a row in the Section table in our database with parent entity c (the course that was just created above),
                # and parse in that section's data
                sec.each do |e|
                    s= Section.create(section_number: e["section"],start_time: e["meetings"][0]["startTime"],end_time: e["meetings"][0]["endTime"],location: e["meetings"][0]["buildingDescription"],monday: e["meetings"][0]["monday"]  ,tuesday: e["meetings"][0]["tuesday"] ,wednesday: e["meetings"][0]["wednesday"],thursday: e["meetings"][0]["thursday"] ,friday:e["meetings"][0]["friday"], saturday: e["meetings"][0]["saturday"] ,sunday: e["meetings"][0]["sunday"] ,mode_of_instruction: e["instructionMode"],course_id: c.id)
                end
            
            end           
        end
    end 
end