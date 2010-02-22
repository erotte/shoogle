class FeetController < ApplicationController
  before_filter :find_current_or_new_foot,  :only =>[:new, :create, :update]
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
    @foot = db.load_document(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @foot }
    end
  end

  # GET /feet /new
  # GET /feet /new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @foot }
    end
  end

  # GET /feet /1/edit
  def edit
    @foot = db.load_document(params[:id])
  end

  # POST /feet 
  # POST /feet .xml
  def create
    @foot = Foot.new params[:foot]
    if db.save(@foot)
      session[:foot_id] = @foot.id
      respond_to do |format|
        format.html { redirect_to edit_foot_path(@foot) }
        format.js   { render :partial => 'feet/add_shoe_form' }
      end
    else 
      render :action => :new
    end
  end

  # PUT /feet /1
  # PUT /feet /1.xml
  def update
    @foot = db.load_document(params[:id])
    if params[:foot][:shoes] and @foot.shoes
      @foot.shoes = params[:foot][:shoes].concat(@foot.shoes)
    else
      @foot.attributes = params[:foot]
    end
    @foot.attributes = params[:foot]
    db.save(@foot)
    respond_to do |format|
      format.html { render :edit }
      format.js   { render :partial => 'feet/shoes' }
    end  
  end

  # DELETE /feet /1
  # DELETE /feet /1.xml
  def destroy
    @foot = db.load_document(params[:id])
    @foot.destroy
    flash[:message] = "Shoe #{params[:id]} destroyed."
    respond_to do |format|
      format.html { redirect_to(feet_path) }
      format.xml  { head :ok }
    end
  end
end
