module FeedbacksHelper

  def feedback_form_options
    {
      :update => 'feedback_wrap',
      :success => "console.debug('success', this)"
    }
  end
end
