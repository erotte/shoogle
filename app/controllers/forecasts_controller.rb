class ForecastsController < ApplicationController
  
  before_filter :find_current_or_create_foot
  
  def index    
  end

  def wizard
    @foot.shoes.build
  end
  
  def add_target_shoe
    @forecast = @foot.fitting params
    respond_to do |format|
      format.html {  }
      format.js { render :partial => 'add_shoe_form',  :layout => false }
    end
  end
  
  
  def show_result
    @forecast = @foot.fitting
    respond_to do |format|
      format.html {  }
      format.js { render :partial => 'fitting_shoes',  :layout => false }
    end
  end
  
  private 
  

end