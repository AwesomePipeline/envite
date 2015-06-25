class Admin::FeedbacksController < FeedbacksController
  def index
    @feedbacks = Feedback.all
  end
end