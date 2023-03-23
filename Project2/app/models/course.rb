class Course < ApplicationRecord
    attr_accessor :term, :campus, :title, :courseId
    include httparty         
      
    def parsing_courses 
        response = HTTParty.get("https://content.osu.edu/v2/classes/search?q=cse&client=class-search-ui&campus=col&term=1234")
        @response = JSON.parse(response.body)
        @pars_resp = response["data"]["courses"]
        pars_resp['course'].each do |c|
            course = Course.create(term: c['term'], campus: c['campus'], courseId: c['courseId'], title: c['title'])

        end
        course.save


    end 
end
