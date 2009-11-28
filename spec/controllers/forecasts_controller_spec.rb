require 'spec_helper'

describe ForecastsController do
  before(:each) do
    Foot.stub!(:new).and_return(@foot = mock_model(Foot))
    session[:foot_id] = nil
  end

  it "should create a new instance of foot" do
    Foot.should_receive(:new).and_return(@foot)
    get :wizard
    assigns(:foot).should be_an_instance_of(Foot)
  end

  it "should persist foot after setting an searched shoe" do
    # Foot.should_receive(:save).and_return(@foot)
    # get :wizard
    # post :add_target_shoe, :with_searched_shoe => false
    # assigns(:foot).should be_an_instance_of(Foot)
  end


end
