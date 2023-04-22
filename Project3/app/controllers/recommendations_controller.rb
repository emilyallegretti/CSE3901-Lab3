# frozen_string_literal: true

class RecommendationsController < ApplicationController
  before_action :check_instr
  # Render an empty form for submitting a new recommendation
  def new
    @recommendation = Recommendation.new
    render :new
  end

  def create
    # Find the student/user that is being recommended
    student = User.find_by(email: params[:recommendation][:student_email], role: 'student')

    # If the student exists, then create a new Recommendation associated with the instructor submitting it
    if !student.nil?
      @recommendation = Recommendation.new(recommendation_params)

      # Save the new Recommendation and send a success message to the submitting user
      if @recommendation.save
        flash[:notice] = 'Recommendation was successfully submitted.'
        redirect_to '/', notice: 'Recommendation was successfully submitted.'
      else
        flash[:notice] = 'Recommendation could not be submitted. Please try again.'
        redirect_to action: :new
      end
    else
      flash[:notice] = 'Student not found. Please make sure the student email is correct.'
      redirect_to action: :new
    end
  end

  # Whitelist parameters from input form
  private

  def recommendation_params
    params.require(:recommendation).permit(:instructor_email, :student_email, :message, :course_name, :section_num,
                                           :user_id)
  end

  def check_instr
    redirect_to '/' unless current_user&.role == 'instructor'
  end
end
