class ForecastsController < ApplicationController
    
  #todo woanders hin!
  def new
    session[:foot_id] = session[:searched_shoe] = nil
    redirect_to root_url
  end
  
  def index
    @foot = Foot.find(params[:foot_id])
  end
  
  def fitting
    @foot = Foot.find(params[:foot_id])
    @forecast = @foot.fitting :manufacturer => @foot.searched_shoe.manufacturer_name, :model => @foot.searched_shoe.model_name
    respond_to do |format|
      format.html
    end
  end


end