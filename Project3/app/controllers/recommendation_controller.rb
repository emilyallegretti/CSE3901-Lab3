class RecommendationController < ApplicationController
  def create
    # Find the student/user that is being recommended
    student = User.find_by(email: sections_user_params[:email], role: 'student')
    
    # If the student exists, then create a new section_user that changes the is_recommended attribute to positive otherwise send a failure message to the user
    if student
      @sections_user = SectionsUser.create(sections_user_params.merge(user_id: student.id, is_recommended: @is_recommended))
      
      # Save the new section user and send a success message to the submitting user
      if @sections_user.save
        redirect_to @sections_user, notice: 'Recommendation was successfully submitted.'
      else
        render :new
      end
    else
      flash.now[:alert] = 'Student not found. Please make sure the student email is correct.'
      @sections_user = SectionsUser.new(sections_user_params)
      render :new
    end
  end
end
