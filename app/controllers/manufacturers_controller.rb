class ManufacturersController < ApplicationController
  # GET /manufacturers
  # GET /manufacturers.xml
  def index
    @manufacturers = db.view(Manufacturer.by_start_of_name(:key => params[:q], :limit => params[:limit]))
    respond_to do |format|
      format.html # index.html.erb
      format.js  { render :partial  => 'list' }
      format.xml  { render :xml => @manufacturers }
    end
  end
end
