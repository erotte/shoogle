class Mailer < ActionMailer::Base
  helper ActionView::Helpers::UrlHelper, :application, :mailer
  def feedback feedback
    subject    'Feedback ssf'
    body       :feedback => feedback
    recipients APP_CONFIG['feedback_mail_recipient']
    from       APP_CONFIG['mail_from']
  end
end
