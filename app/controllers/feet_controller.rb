class FeetController < ApplicationController
  # GET /feet 
  # GET /feet .xml
  def index
    @feet  = Foot.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feet }
    end
  end

  # GET /feet /1
  # GET /feet /1.xml
  def show
    @foot = Foot.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @foot }
    end
  end

  # GET /feet /new
  # GET /feet /new.xml
  def new
    @foot = Foot.new
    3.times {@foot.shoes.build}
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @foot }
    end
  end

  # GET /feet /1/edit
  def edit
    @foot = Foot.find(params[:id])
  end

  # POST /feet 
  # POST /feet .xml
  def create
      @foot = Foot.new params[:foot]
      if @foot.save 
        if params[:manufacturer].present? and params[:model].present?
          redirect_to fitting_url(@foot, :manufacturer => params[:manufacturer], :model => params[:model])
        else
          redirect_to foot_path(@foot)
        end
      else 
        render :action => :new
      end
  end

  # PUT /feet /1
  # PUT /feet /1.xml
  def update
    @foot = Foot.find(params[:id])
    @foot.update_attributes(params[:foot])
    respond_to do |format|
      format.html # new.html.erb
      format.js  { render :partial => 'feet/shoe', :collection => @foot.shoes }
    end  
  end

  # DELETE /feet /1
  # DELETE /feet /1.xml
  def destroy
    @foot = Foot.find(params[:id])
    @foot.destroy
    respond_to do |format|
      format.html { redirect_to(feet_path) }
      format.xml  { head :ok }
    end
  end
end
