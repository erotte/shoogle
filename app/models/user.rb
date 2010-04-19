class User
  include CouchPotato::Persistence
  
  class << self
    include Devise::Models
  end
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
  
  property :foot_id
  
  view :by_id, :key => :_id
  view :by_email, :key => :email
  view :by_reset_password_token, :key => :reset_password_token
  
  before_save :find_foot
  
  def find_foot
    
  end
  
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
    else
      Rails.logger.warn '!!!\n!!! not implemented\n!!!'
    end
    
    result = found.any? ? found.first : nil
    Rails.logger.debug "--- found ->#{result}<-"
    result
  end
  
end