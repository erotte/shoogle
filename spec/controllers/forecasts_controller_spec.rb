require 'spec_helper'

describe ForecastsController do
  before(:each) do
    session[:foot_id] = nil
    Foot.stub!(:new).and_return(@foot = mock_model(Foot))
  end

  it "should create a new instance of foot" do
    Foot.should_receive(:new).and_return(@foot)
    get :wizard
    foot = assigns(:foot)
    p foot
    foot.should be_an_instance_of(Foot)
    # foot.should be_new_record
    
  end

  it "should persist foot after setting an searched shoe" do
    # Foot.should_receive(:save).and_return(@foot)
    # get :wizard
    # post :add_target_shoe, :with_searched_shoe => false
    # assigns(:foot).should be_an_instance_of(Foot)
  end


end
