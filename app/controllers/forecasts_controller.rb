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
    a = @foot.shoes.last
    b = @foot.searched_shoe
    key = [a.manufacturer, b.manufacturer_name, a.model, b.model_name, a.size]
#    key.why?
    @forecast = db.view(Foot.fitting(:key => key)).why?# :manufacturer => @foot.searched_shoe.manufacturer_name, :model => @foot.searched_shoe.model_name
    respond_to do |format|
      format.html
    end
  end

end