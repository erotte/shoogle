class FeedbacksController < ApplicationController
  before_filter :collect_ua_data, :only => [:create, :update]
  # GET /feedbacks
  # GET /feedbacks.xml
  def index
    @feedbacks = db.view(Feedback.all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @feedbacks }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.xml
  def show
    @feedback = db.load_document(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feedback }
    end
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.xml
  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.js {render :layout => false }
      format.xml  { render :xml => @feedback }
    end
  end

  # GET /feedbacks/1/edit
  def edit
    @feedback = db.load_document(params[:id])
  end

  # POST /feedbacks
  # POST /feedbacks.xml
  def create
    sleep 0.2
    @feedback = Feedback.new(params[:feedback])
    collect_ua_data
    respond_to do |format|
      if db.save(@feedback)
        format.html { redirect_to(@feedback, :notice => 'Feedback was successfully created.') }
        format.js do
          flash.now[:notice] = "Vielen Dank für dein Feedback!"
          render :partial => 'feedbacks/completed', :layout => false
        end
        format.xml  { render :xml => @feedback, :status => :created, :location => @feedback }
      else
        format.html { render :action => "new" }
        format.js { render :action => "new", :layout => false, :success => false}
        format.xml  { render :xml => @feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.xml
  def update
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      if @feedback.update_attributes(params[:feedback])
        format.html { redirect_to(@feedback, :notice => 'Feedback was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.xml
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to(feedbacks_url) }
      format.xml  { head :ok }
    end
  end

  def collect_ua_data
    return unless @feedback.present?
    @feedback.ua = request.env['HTTP_USER_AGENT']
#    @feedback.session_data = request.env.to_json
  end

end
