#TESTING
class ParserService
    include HTTParty         
    default_params fielsd: "term, campus, courseId, title"
    format :json


    def parsing_courses 
        response = HTTParty.get("https://content.osu.edu/v2/classes/search?q=cse&client=class-search-ui&campus=col&term=1234")
        @response = JSON.parse(response.body)
        @pars_resp = @response["data"]["courses"]
        pars_resp.each do |c|
            @courses = Course.create(term: k['term'], campus: k['campus'], courseId: k['courseId'], title: k['title'])

          end
        end  
    end