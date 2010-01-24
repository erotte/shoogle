require 'spec_helper'

describe ForecastsController do
  before(:each) do
    session[:foot_id] = nil
    Foot.stub!(:new).and_return(@foot = mock_model(Foot))
  end



end
