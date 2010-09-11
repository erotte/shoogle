class Feedback
  include CouchPotato::Persistence
  after_save :send_as_mail
  property :firstname
  property :lastname
  property :email
  property :message
  property :created_at, :type => Time
  property :ua
  property :session_data

  validates_true_for :email,
                     :logic => Proc.new{|v| ev = EmailVeracity::Address.new(v.email);ev.valid? && !ev.domain.blacklisted?},
                     :message => "Bitte gib eine gültige Email-Adresse an"

  validates_presence_of :message, :message => "Bitte gib eine Nachricht ein"

  view :all, :key => :created_at

  private

  def send_as_mail
    Mailer.deliver_feedback(self)
  end

end
