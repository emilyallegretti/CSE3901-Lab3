module Services
    class Parsing
        include HTTParty
        base_uri "https://content.osu.edu/v2/classes/search"
        default_params q: "cse", client: "class-search-ui"
        format :json
        #"campus=col&term=1234"
        def initialize(campus_q, term_q)
            @options = { query: {campus: campus_q, term: term_q} }
        end

        def self.load (campus_q, term_q)
            @pars_resp = get("",{ query: {campus: campus_q, term: term_q} })["data"]["courses"]
            #load in courses data
            @pars_resp.each do |k|
                Course.create(name: k["course"]["title"],number: k["course"]["catalogNumber"],term: k["course"]["term"],campus: k["course"]["campus"])
                @sec= k["sections"]
                #load in sections data
                @sec.each do |e|
                    Section.create(section_number: e["section"],start_time: e["meetings"][0]["startTime"],end_time: e["meetings"][0]["endTime"],location: e["meetings"][0]["buildingDescription"],monday: e["meetings"][0]["monday"]  ,tuesday: e["meetings"][0]["tuesday"] ,wednesday: e["meetings"][0]["wednesday"],thursday: e["meetings"][0]["thursday"] ,saturday: e["meetings"][0]["saturday"] ,sunday: e["meetings"][0]["sunday"] ,mode_of_instruction: e["instructionMode"],course_num: k["course"]["catalogNumber"])#Manually course_num
                end
            end           
        end
    end 
end
