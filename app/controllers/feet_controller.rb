class FeetController < ApplicationController
  before_filter :find_current_or_new_foot,  :only =>[:new, :create, :update]

  expose(:foot) do
    find_current_or_new_foot
  end

  def show
  end

  def new
    if foot.new_record?
      respond_with foot
    else
      redirect_to edit_foot_path(foot)
    end
  end

  def edit
  end

  def create
    foot = Foot.new params[:foot]
    if foot.valid? and db.save!(foot)
      session[:foot_id] = foot.id
      save_foot_to_current_user
      redirect_to :root# edit_foot_path(foot)
    else
      render :new   
    end
  end

  def update
    foot = db.load_document(params[:id])
    foot.attributes = params[:foot]
    db.save(foot)
    respond_with foot
  end

  # DELETE /feet /1
  # DELETE /feet /1.xml
  def destroy
    db.destroy_document foot
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
      user.foot_id = foot.id
      db.save!(user)
    end
  end

end
