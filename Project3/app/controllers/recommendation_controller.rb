class RecommendationController < ApplicationController
  def create
    @recommendation = Recommendation.new(recommendation_params)
    
    # Find or create the student by email
    student = User.find_or_create_by(email: recommendation_params[:email]) do |new_student|
      # Set default values for the new student if needed
      new_student.first_name = 'Unknown'
      new_student.last_name = 'Unknown'
    end
    
    @recommendation.student_id = student.id
  
    if @recommendation.save
      redirect_to @recommendation, notice: 'Recommendation was successfully submitted.'
    else
      render :new
    end
  end
end
