class ForecastsController < ApplicationController
  before_filter :find_current_or_new_foot,  :only =>[:index, :fitting]  
  before_filter :redirect_to_root_url_for_invalid_foot, :only =>[:fitting]
  before_filter :redirect_to_index_for_empty_searched_shoe, :only =>[:fitting]
  before_filter :find_affiliate_shoe, :only =>[:fitting]
  
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
      format.js do
        render :partial => 'affiliate_shoe/show', :locals => {:affiliate_shoes => @affiliate_shoes}
      end
    end
  end
  
  private

  def find_affiliate_shoe
    searched_shoe = @foot.searched_shoe
    @affiliate_shoes = AffiliateShoe.find(:manufacturer => searched_shoe.manufacturer_name, :model => searched_shoe.model_name)
    if @affiliate_shoes.empty?
      @fallback_to_manufacturer_search = true
      @affiliate_shoes = AffiliateShoe.find(:manufacturer => searched_shoe.manufacturer_name)
    end
    @affiliate_shoes = @affiliate_shoes.paginate(:per_page => 10, :page => params[:page])
  end

  def redirect_to_index_for_empty_searched_shoe
    unless @foot.searched_shoe && @foot.searched_shoe.manufacturer_name.present?
      redirect_to :action => :index 
    end
  end
  
  def redirect_to_root_url_for_invalid_foot
    redirect_to root_url unless @foot.has_valid_shoes?
  end
  
end
