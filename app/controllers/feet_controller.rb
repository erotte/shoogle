require 'Shoe' unless defined? Shoe

class FeetController < ApplicationController
  before_filter :find_current_or_new_foot,  :only =>[:new, :create, :update]

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
    if @foot.new_record?  
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @foot }
      end      
    else
      redirect_to edit_foot_path(@foot)
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
    if @foot.valid? and db.save!(@foot)
      session[:foot_id] = @foot.id
      save_foot_to_current_user
      respond_to do |format|
        format.html { redirect_to edit_foot_path(@foot) }
        format.js   { render :edit, :layout => false }
      end
    else 
      respond_to do |format|
        format.html { render :new }
        format.js   { render :new, :layout => false }
      end
    end
  end

  # PUT /feet /1
  # PUT /feet /1.xml
  def update
    @foot = db.load_document(params[:id])
    @foot.attributes = params[:foot]
    if @foot.valid?
      db.save(@foot)
      respond_to do |format|
        format.html { render :edit }
        format.js   { render :edit, :layout => false }
      end
    else 
      respond_to do |format|
        format.html { render :new }
        format.js   { render :new, :layout => false }
      end
    end
  end

  # DELETE /feet /1
  # DELETE /feet /1.xml
  def destroy
    @foot = db.load_document(params[:id])
    db.destroy_document @foot
    flash[:message] = "Shoe #{params[:id]} destroyed."
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def save_foot_to_current_user
    user = current_user
    if user
      user.foot_id = @foot.id 
      db.save!(user)
    end
  end
  
end
