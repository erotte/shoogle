class SearchedShoesController < ApplicationController
  
  def new
    delete_and_show_foot
  end  

  def edit
    @foot = db.load_document(params[:foot_id])
    respond_to do |format|
      format.js { render :partial => "/feet/searched_shoe_form" }
      format.html { redirect_to(edit_foot_path(@foot)) }
      format.xml  { head :ok }
    end
  end  

  def destroy
    delete_and_show_foot
  end
  
  private
  
  def delete_and_show_foot
    @foot = db.load_document(params[:foot_id])
    @foot.searched_shoe = nil
    db.save!(@foot)
    respond_to do |format|
      format.js {  render "feet/edit", :layout => false }
      format.html { redirect_to(edit_foot_path(@foot)) }
      format.xml  { head :ok }
    end
  end
  
end
