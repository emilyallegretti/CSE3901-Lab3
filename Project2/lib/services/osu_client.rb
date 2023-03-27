module Services
    class OsuClient
        def self.save_data_from_api 
            response = HTTParty.get("https://content.osu.edu/v2/classes/search?q=cse&client=class-search-ui&campus=col&term=1234")
            @response = JSON.parse(response.body)
            @pars_resp = response["data"]["courses"]
            #load in courses data
            @pars_resp.each do |k|
                Course.create(name: k["course"]["title"],number: k["course"]["catalogNumber"],term: k["course"]["term"],campus: k["course"]["campus"])
                @sec= k["sections"]
                #load in sections data
                @sec.each do |e|
                    Section.create(section_number: e["section"],start_time: e["meetings"][0]["startTime"],end_time: e["meetings"][0]["endTime"],location: e["meetings"][0]["buildingDescription"],mode_of_instruction: e["instructionMode"])
                    
                end
            end           
        end
    end 
end
