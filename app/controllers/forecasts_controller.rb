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
    if @foot.id
      render "search"
    else
      render "search_with_new_foot"
    end
  end
  
  private 
  
  def fetch_foot
    begin
      @foot = Foot.find params[:foot_id] 
    rescue
      @foot = Foot.new
      3.times {@foot.shoes.build}
    end
  end
end