class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end
  
  def create
    @feedback = Feedback.new(feedback_params)
    
    if @feedback.save!
      flash[:success] = t(:feedback_create_success)
    else
      flash[:error] = t(:feedback_create_error)
    end
    
    redirect_to :back
  end
  
  protected
    def feedback_params
      params.require(:feedback).permit(:feedback_type, :details)
    end
end
