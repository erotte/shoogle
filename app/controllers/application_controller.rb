# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :enhance_new_registering_user_with_current_foot, :only => [:create]
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  
  protected
  
  def db
     CouchPotato.database
  end
   
  private
    
  def find_current_or_new_foot
    if params[:foot_id]
      @foot = db.load_document(params[:foot_id])
    elsif session[:foot_id]
      @foot = db.load_document(session[:foot_id])
    else
      @foot = Foot.new unless @foot
    end
    @foot
  end
  
  # filter um vor devise-neuregistrierung user-model zu vervollständigen 
  def enhance_new_registering_user_with_current_foot
    if params[:controller] == "registrations" and params[:user]
      params[:user][:foot_id] = params[:foot_id] || session[:foot_id]
    end
  end

  # devise-hook bei erfolgreichem login pfad zu bauen
  def after_sign_in_path_for(resource)
    if resource.is_a?(User) && resource.foot_id?
      session[:foot_id] = resource.foot_id
      new_foot_searched_shoes_path(resource.foot_id)
    else
      super
    end
  end

end
