class DataController < ApplicationController
  include HTTParty
  def home
      response = HTTParty.get("https://content.osu.edu/v2/classes/search?q=cse&client=class-search-ui&campus=col&term=1234")
      @response = JSON.parse(response.body)
      @courses = @response["data"]["courses"]

      
  end

end
