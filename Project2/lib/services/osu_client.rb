module Services
    class OsuClient

        def self.save_data_from_api 
            response = HTTParty.get("https://content.osu.edu/v2/classes/search?q=cse&client=class-search-ui&campus=col&term=1234")
            @response = JSON.parse(response.body)
            @pars_resp = response["data"]["courses"]
            @pars_resp['course'].each do |c|
            course = Course.create(term: c['term'], campus: c['campus'], catalogNum: c['catalogNumber'], title: c['title'])

            end
            course.save
            course #return
        end
    end 
end
