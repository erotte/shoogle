class FeetController < ApplicationController
  # GET /feet 
  # GET /feet .xml
  def index
    @feet  = Foot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feet  }
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
    @foot = Foot.new(params[:foot])
    @foot.save ? redirect_to(feet_path) : render(:action => :new)
  end

  # PUT /feet /1
  # PUT /feet /1.xml
  def update
    @foot = Foot.find(params[:id])
    @foot.update_attributes(params[:person]) ?
        redirect_to(foot_path(@person)) : render(:action => :edit)
  end

  # DELETE /feet /1
  # DELETE /feet /1.xml
  def destroy
    @foot = Foot.find(params[:id])
    @foot.destroy

    respond_to do |format|
      format.html { redirect_to(feet_url) }
      format.xml  { head :ok }
    end
  end
end
