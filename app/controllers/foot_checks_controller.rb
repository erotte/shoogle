class FootChecksController < ApplicationController

  def index
    @foot = db.load_document(params[:id])
    @foot_check = FootCheck.new :foot => @foot
  end
end
