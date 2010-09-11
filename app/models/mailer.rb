class Mailer < ActionMailer::Base
  helper ActionView::Helpers::UrlHelper, :application, :mailer
  def feedback feedback
    subject    'Feedback ssf'
    body       :feedback => feedback
    recipients "erotte@gmail.com"
    from       "mailer@shoesizefinder.com"
  end
end
