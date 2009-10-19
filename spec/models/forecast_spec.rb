require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Forecast do
  
  before(:each) do
    @foot = mock('foot')
    @foot.stub(:shoes).and_return []
    
    @direct_matches = mock('direct_matches')
    @foot.stub(:direct_matches).and_return @direct_matches
    @direct_matches.stub(:find_all_by_manufacturer_name_and_model_name).and_return []
    
    @transposed_matches = mock('transposed_matches')
    @foot.stub(:transposed_matches).and_return @transposed_matches
    @transposed_matches.stub(:find_all_by_manufacturer_name_and_model_name).and_return []
  end
  
  it "should compute median for direct matches" do
    
    @direct_matches.stub(:find_all_by_manufacturer_name_and_model_name).and_return [
      mock('match44',   :size => 44),
      mock('match44_2', :size => 44),
      mock('match45',   :size => 45),
      mock('match45',   :size => 45.5),
      mock('match46',   :size => 46),
      mock('match50',   :size => 50)]
    
    forecast = Forecast.new :foot => @foot, :manufacturer => "Nike", :model => "AF1"
    
    forecast.size.should == 45.25
  end
  
  it "should compute median for transposed matches" do

    @transposed_matches.stub(:find_all_by_manufacturer_name_and_model_name).and_return [
      mock('match44',   :transposed_size => 44),
      mock('match44_2', :transposed_size => 44),
      mock('match45',   :transposed_size => 45),
      mock('match45',   :transposed_size => 45.5),
      mock('match46',   :transposed_size => 46),
      mock('match50',   :transposed_size => 50)]
    
    forecast = Forecast.new :foot => @foot, :manufacturer => "Nike", :model => "AF1"
    
    forecast.size.should == 45.25
  end
end