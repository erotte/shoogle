class ShoesController < ApplicationController
  
  before_filter :find_current_or_new_foot

  def create
    @shoe = Shoe.new(params[:shoe])    
    if @shoe.valid?
      @foot.shoes << @shoe
      db.save_document @foot
      @shoe = Shoe.new
    end
    respond_to do |format|
      format.js   { render :partial => 'feet/shoe_area' }
    end
  end

  def destroy
    @foot.shoes.delete_at params[:id].to_i
    db.save_document @foot
    respond_to do |format|
      format.js   { render :partial => 'feet/shoes' }
      format.html { redirect_to :back }
    end
  end
end
