class ForecastsController < ApplicationController
  
  before_filter :find_current_or_create_foot, :except => [:new, :wizard]
  before_filter :find_current_or_new_foot, :only =>  :wizard
  before_filter :set_seached_shoe
  
  helper_method :searched_shoe
  
  def index    
  end

  def wizard
  end
  
  def new
    session[:foot_id] = session[:searched_shoe] = nil
    redirect_to root_url
  end
  
  def add_target_shoe
    @searched_shoe = session[:searched_shoe] = SearchedShoe.new(params) unless params.blank?
    respond_to do |format|
      format.html { render :wizard }
      format.js { render :partial => 'add_shoe_form',  :layout => false  }
    end
  end
  
  def fitting
    @forecast = @foot.fitting :manufacturer => searched_shoe.manufacturer, :model => searched_shoe.model
    respond_to do |format|
      format.html
    end
  end

  protected

  def set_seached_shoe
    @searched_shoe = session[:searched_shoe]
  end
  
  def searched_shoe 
    session[:searched_shoe]
  end

end