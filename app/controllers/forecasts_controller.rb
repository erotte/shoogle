class ForecastsController < ApplicationController
  def index
    foot = Foot.find params[:foot_id]
    @forecast = foot.fitting params
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shoes }
    end
  end
end