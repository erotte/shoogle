class ForecastsController < ApplicationController
  
  before_filter :find_current_or_create_foot
  
  def index    
  end

  def wizard
    @foot.shoes.build
  end
  
  def new
    session[:foot_id] = nil
    redirect_to root_url
  end
  
  def add_target_shoe
    place_target_shoe
    respond_to do |format|
      format.html {  }
      format.js { render :partial => 'add_shoe_form',  :layout => false }
    end
  end
  
  def fitting
    @forecast = @foot.fitting :manufacturer => session[:searched_manufacturer], :model => session[:searched_model]
    respond_to do |format|
      format.html
    end
  end

  private
  
  def place_target_shoe
    session[:searched_manufacturer] = params[:manufacturer]
    session[:searched_model] = params[:model]
  end
end