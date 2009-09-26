class ForecastsController < ApplicationController
  
  before_filter :fetch_foot
  
  def index    
  end
  
  def fitting
    @forecast = @foot.fitting params
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shoes }
    end
  end
  
  def search
  end
  
  private 
  
  def fetch_foot
    @foot = Foot.find params[:foot_id]
  end
end