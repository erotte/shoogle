class ShoeTypesController < ApplicationController
  
  def models
    if params[:manufacturer].present? and params[:q].present?
      @shoe_types = db.view(Shoe.names_by_start_of_name(
        :startkey => [params[:q], params[:manufacturer]], 
        :endkey   => [params[:q], params[:manufacturer],{}],
        :limit => params[:limit] ))
    end
    respond_to do |format|
      format.js  { render 'models.js', :layout => false}
    end
  end
  
end
