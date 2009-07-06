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

    3.times{@foot.shoes << Shoe.new}
    
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
    @foot = Foot.new(params[:entry])

    respond_to do |format|
      if @foot.save
        flash[:notice] = 'Foot was successfully created.'
        format.html { redirect_to(@foot) }
        format.xml  { render :xml => @foot, :status => :created, :location => @foot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @foot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feet /1
  # PUT /feet /1.xml
  def update
    @foot = Foot.find(params[:id])

    respond_to do |format|
      if @foot.update_attributes(params[:entry])
        flash[:notice] = 'Foot was successfully updated.'
        format.html { redirect_to(@foot) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @foot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feet /1
  # DELETE /feet /1.xml
  def destroy
    @foot = Foot.find(params[:id])
    @foot.destroy

    respond_to do |format|
      format.html { redirect_to(feet _url) }
      format.xml  { head :ok }
    end
  end
end
