class User
  include CouchPotato::Persistence

#  validates_acceptance_of :agb_accept, :message => "Bitte akzeptiere unsere Nutzungsbedingungen"

  class << self
    include Devise::Models
  end
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable
  
  property :foot_id
  property  :agb_accept, :type => :boolean
  
  view :by_id, :key => :_id
  view :by_email, :key => :email
  view :by_reset_password_token, :key => :reset_password_token
  view :by_confirmation_token, :key => :confirmation_token

  def self.first options
    Rails.logger.debug options.inspect
    conditions = options[:conditions]
    if not conditions or conditions.size > 1
      Rails.logger.warn '!!!\n!!! not implemented\n!!!'
    elsif conditions.include? :id
      found = CouchPotato.database.view(User.by_id(:key => conditions[:id], :limit => 1))
    elsif conditions.include? :email
      found = CouchPotato.database.view(User.by_email(:key => conditions[:email], :limit => 1))
    elsif conditions.include? :reset_password_token
      found = CouchPotato.database.view(User.by_reset_password_token(:key => conditions[:reset_password_token], :limit => 1))
    elsif conditions.include? :confirmation_token
      found = CouchPotato.database.view(User.by_confirmation_token(:key => conditions[:confirmation_token], :limit => 1))
    else
      Rails.logger.warn "!!!\n!!! not implemented\n!!!\noptions=#{options.inspect}"
    end
    
    result = found.any? ? found.first : nil
    Rails.logger.debug "--- found ->#{result}<-"
    result
  end
  
  def update_attributes attributes
    attributes.each do |key, value|
      meth = "#{key}=".to_sym
      self.send(meth, value) if self.respond_to? meth
    end
    CouchPotato.database.save! self
  end
  
  def destroy
    CouchPotato.database.destroy_document(self)
  end
end
