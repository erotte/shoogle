# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  USER_NAME, PASSWORD = "shoomoo", "mooshoo"
  before_filter :guard_beta_app, :except => [ :index ] if RAILS_ENV.eql?('production')
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :enhance_new_registering_user_wiht_current_foot, :only => [:create]
  def enhance_new_registering_user_wiht_current_foot
    if params[:controller] == "registrations" and params[:user]
      params[:user][:foot_id] = params[:foot_id] || session[:foot_id]
    end
  end

  def db
     CouchPotato.database
  end
   
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  private
  def guard_beta_app
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == USER_NAME && password == PASSWORD
    end
  end

  def find_current_or_new_foot
    if params[:foot_id]
      @foot = db.load_document(params[:foot_id])
    else
      @foot = session[:foot_id].blank? ? Foot.new : db.load_document(session[:foot_id])
    end
    unless @foot 
      redirect_to :action => :new, :controller => :forecasts
    end
  end 

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.foot_id?
      session[:foot_id] = resource.foot_id
      edit_foot_path(resource.foot_id)
    else
      super
    end
  end

end
