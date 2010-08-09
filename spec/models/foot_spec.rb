require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Foot do
  before(:each) do
    shoe = Shoe.new :manufacturer => "Adidas", :model => "Samba", :sizes => {:eur => 45}
    searched_shoe = SearchedShoe.new :manufacturer_name => "Nike", :model_name => "AF1" 
    
    @foot = Foot.new
    @foot.searched_shoe = searched_shoe
    @foot.shoes = [shoe]
    
    @db = mock("CouchPotato Database Mock")
    @foot.stub!(:db).and_return @db
    Foot.stub!(:fitting)    
  end
  
  describe "when computing direct matches" do
    
    it "should handle empty rows without error" do
      @db.should_receive(:view).and_return( {"rows"=>[]} )
      matches = @foot.direct_matches
      matches.should be_empty
    end
    
  end
  
  describe "when computing transposed matches" do 
    
    it "should yield a match" do  
      @db.should_receive(:view).and_return({
        "rows" => [{ 
            "key" => ["eur","Adidas","Nike","Samba","AF1"], 
            "value" => {"size_sum" => 2, "num_feet" => 2} }]
      })
      matches = @foot.transposed_matches
      matches.size.should eql(1)
    end    
    
    it "should ignore a match if keys aren't identical" do  
      @db.should_receive(:view).and_return({
        "rows" => [{ 
            "key" => ["eur","Adidas","Nike","Samba","Dunk"], 
            "value" => {"size_sum" => 2, "num_feet" => 2} }]
      })
      matches = @foot.transposed_matches
      matches.should be_empty
    end
    
  end
end