module FeedbacksHelper

  def feedback_form_options
    {
      :update => 'feedback_wrap',
      :remote => true
    }
  end
end
