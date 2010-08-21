class ForecastsController < ApplicationController
  before_filter :find_current_or_new_foot,  :only =>[:index, :fitting]  
  before_filter :find_affiliate_shoe, :only =>[:fitting]

  #todo woanders hin! .. hmm vielleicht doch nicht. man möchte ja tatsächlich einen neuen forecast beginnen
  def new
    session[:foot_id] = session[:searched_shoe] = nil
    redirect_to root_url
  end
  
  def index
  end
  
  
  def fitting
    redirect_to root_url unless @foot.valid?
    
    @forecast = Forecast.new(:foot => @foot)
    respond_to do |format|
      format.html
    end
  end
  
  private
  
  def find_affiliate_shoe
    searched_shoe = @foot.searched_shoe
    @affiliate_shoes = AffiliateShoe.find(:manufacturer => searched_shoe.manufacturer_name, :model => searched_shoe.model_name)
    if @affiliate_shoes.empty?
      @affiliate_shoes = AffiliateShoe.find(:manufacturer => searched_shoe.manufacturer_name)
    end
  end

end
