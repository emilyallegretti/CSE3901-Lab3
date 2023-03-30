class ReloadController < ApplicationController
  
    
  # get an HTML form with the help of an empty Course for inputting filters on the reload
  def new
    @course= Course.new
  end
end