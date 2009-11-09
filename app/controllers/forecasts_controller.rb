class ForecastsController < ApplicationController
  
  before_filter :find_current_or_create_foot
  helper_method :searched_shoe
  
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
    @searched_shoe = session[:searched_shoe] = SearchedShoe.new(params[:searched_shoe])
    @searched_shoe.validate
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
  
  def searched_shoe 
    session[:searched_shoe]
  end
end