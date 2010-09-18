require 'Shoe' unless defined? Shoe

class Admin::FeetController < Admin::BaseController
  def index
    @feet  = db.view(Foot.all)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @feet }
    end
  end
end
