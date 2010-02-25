class ForecastsController < ApplicationController
  before_filter :find_current_or_new_foot,  :only =>[:index, :fitting]  

  #todo woanders hin! .. hmm vielleicht doch nicht. man möchte ja tatsächlich einen neuen forecast beginnen
  def new
    session[:foot_id] = session[:searched_shoe] = nil
    redirect_to root_url
  end
  
  def index
  end
  
  
  def fitting
    @forecast = Forecast.new(:foot => @foot)
    respond_to do |format|
      format.html
    end
  end

end