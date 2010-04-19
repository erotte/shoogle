class FootChecksController < ApplicationController

  def index
    @foot = Foot.find(params[:foot_id])
    @foot_check = FootCheck.new :foot => @foot
  end
end