class ShoesController < ApplicationController
  # GET /shoes
  # GET /shoes.xml
  def index
    @shoes = Shoe.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shoes }
    end
  end

  # GET /shoes/1
  # GET /shoes/1.xml
  def show
    @shoe = Shoe.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shoe }
    end
  end

  # GET /shoes/new
  # GET /shoes/new.xml
  def new
    @shoe = Shoe.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shoe }
    end
  end

  # GET /shoes/1/edit
  def edit
    @shoe = Shoe.find(params[:id])
  end

  # POST /shoes
  # POST /shoes.xml
  def create
    @shoe = Shoe.new(params[:shoe])

    respond_to do |format|
      if @shoe.save
        flash[:notice] = 'Shoe was successfully created.'
        format.html { redirect_to(@shoe) }
        format.xml  { render :xml => @shoe, :status => :created, :location => @shoe }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shoe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shoes/1
  # PUT /shoes/1.xml
  def update
    @shoe = Shoe.find(params[:id])

    respond_to do |format|
      if @shoe.update_attributes(params[:shoe])
        flash[:notice] = 'Shoe was successfully updated.'
        format.html { redirect_to(@shoe) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shoe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shoes/1
  # DELETE /shoes/1.xml
  def destroy
    @shoe = Shoe.find(params[:id])
    @shoe.destroy

    respond_to do |format|
      format.html { redirect_to(shoes_url) }
      format.xml  { head :ok }
    end
  end
end
