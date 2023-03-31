module Services
    class Parsing
        include HTTParty
        base_uri "https://content.osu.edu/v2/classes/search"
        default_params q: "cse", client: "class-search-ui", p: "1" #academic-career: "ugrd"
        format :json

        def initialize(campus_q, term_q)
            @options = { query: {campus: campus_q, term: term_q} }
        end

        def self.load (campus_q, term_q)
            if term_q == ""
                @pars_resp = get("",{ query: {campus: campus_q} })["data"]["courses"]
            else
                @pars_resp = get("",{ query: {campus: campus_q, term: term_q} })["data"]["courses"]
            end
#puts @pars_resp
            #load in courses data
            @pars_resp.each do |k|
                c = Course.create(name: k["course"]["title"],number: k["course"]["catalogNumber"],term: k["course"]["term"],campus: k["course"]["campus"])
                puts c
                sec= k["sections"]
              puts sec
                #load in sections data
                sec.each do |e|
                    s= Section.create(section_number: e["section"],start_time: e["meetings"][0]["startTime"],end_time: e["meetings"][0]["endTime"],location: e["meetings"][0]["buildingDescription"],monday: e["meetings"][0]["monday"]  ,tuesday: e["meetings"][0]["tuesday"] ,wednesday: e["meetings"][0]["wednesday"],thursday: e["meetings"][0]["thursday"] ,saturday: e["meetings"][0]["saturday"] ,sunday: e["meetings"][0]["sunday"] ,mode_of_instruction: e["instructionMode"],course_id: c.id)
                end
            end           
        end
    end 
end