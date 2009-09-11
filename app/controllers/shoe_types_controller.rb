class ShoeTypesController < ApplicationController
  
  def models
    
    if params[:manufacturer].present?
      manufacturer = Manufacturer.find(:first, :conditions => ['name LIKE ?', "#{params[:manufacturer]}"])
      if manufacturer
        @shoe_type = ShoeType.find(:all, :conditions => ['model LIKE ? and manufacturer_id = ?', "%#{params[:q]}%", manufacturer.id])
      end
    end
    respond_to do |format|
      format.js  { render 'models.js', :layout => false}
    end
  end
end