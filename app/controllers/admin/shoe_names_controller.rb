
class Admin::ShoeNamesController < Admin::BaseController
  def index
    @shoe_names  = Shoe.unapproved_names
    respond_to do |format|
      format.html { render 'shoe_names/index' }
      format.xml  { render :xml => @shoe_names }
    end
  end
  
  def approve_shoes
    feet = Shoe.unapproved_by_model_and_manufacturer(:manufacturer => params[:manufacturer], :model => params[:model])
    feet.each do |foot|
      shoes = foot.shoes.select{ |shoe| shoe.manufacturer == params[:manufacturer] && shoe.model == params[:model]}
      shoes.each{|shoe| shoe.approved = true}
      db.save_document foot
    end
    redirect_to :back
  end
end