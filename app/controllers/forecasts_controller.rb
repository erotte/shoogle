class ForecastsController < ApplicationController
  
  before_filter :find_current_or_create_foot
  
  def index    
  end

  def wizard
    @foot.shoes.build
  end
  
  def add_target_shoe
    @forecast = Forecast.new  params.merge(:foot => @foot)
    respond_to do |format|
      format.html {  }
      format.js { render :partial => 'add_shoe_form',  :layout => false }
    end
  end
  
  
  def show_result
    @forecast.update_attributes :foot => @foot
    respond_to do |format|
      format.html {  }
      format.js { render :partial => 'fitting_shoes',  :layout => false }
    end
  end
  
  private 
  

end