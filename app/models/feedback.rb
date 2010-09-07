class Feedback
  include CouchPotato::Persistence

  property :firstname
  property :lastname
  property :email
  property :message
  property :created_at, :type => Time
  property :ua

  validates_presence_of :email
  validates_presence_of :message

  view :all, :key => :created_at

end
