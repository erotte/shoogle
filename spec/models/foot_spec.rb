require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Foot do
  before(:each) do
    
    @samba   = Shoe.new :manufacturer => "Adidas",   :model => "Samba",   :sizes => {:eur => 45}
    @allstar = Shoe.new :manufacturer => "Converse", :model => "Allstar", :sizes => {:eur => 44.5}
    
    searched_shoe = SearchedShoe.new :manufacturer_name => "Nike", :model_name => "AF1" 
    
    @foot = Foot.new
    @foot.searched_shoe = searched_shoe
    @foot.shoes = [@samba, @allstar]
  end

  describe "it should validate" do
    p Factory.build(:shoe)
  end

  #describe "when computing direct matches" do
  #
  #  it "should handle empty rows without error" do
  #    @db.should_receive(:view).twice.and_return( {"rows"=>[]} )
  #    matches = @foot.direct_matches
  #    matches.should be_empty
  #  end
  #
  #  it "should yield a match" do
  #    @db.should_receive(:view).and_return({
  #      "rows" => [{
  #          "key" => ["eur","Adidas","Nike","Samba","AF1", 45],
  #          "value" => {"size_sum" => 2, "num_feet" => 2} }]
  #    }, {
  #      "rows" => []
  #    })
  #    matches = @foot.direct_matches
  #    matches.size.should eql(1)
  #  end
  #
  #  it "should skip shoes without model name" do
  #    @db.should_receive(:view).once.and_return({
  #      "rows" => [{
  #          "key" => ["eur","Adidas","Nike","Samba","AF1", 45],
  #          "value" => {"size_sum" => 2, "num_feet" => 2} }]
  #    })
  #
  #    shoe_without_model_name = Shoe.new :manufacturer => "Rieker", :model => "", :sizes => {:eur => 45}
  #    @foot.shoes = [@samba, shoe_without_model_name]
  #
  #    matches = @foot.direct_matches
  #    matches.size.should eql(1)
  #  end
  #
  #end
  #
  #
  #
  #describe "when computing transposed matches" do
  #
  #  it "should yield a match" do
  #    @db.should_receive(:view).and_return({
  #      "rows" => [{
  #          "key" => ["eur","Adidas","Nike","Samba","AF1"],
  #          "value" => {"size_sum" => 2, "num_feet" => 2} }]
  #    }, {
  #      "rows" => []
  #    })
  #    matches = @foot.transposed_matches
  #    matches.size.should eql(1)
  #  end
  #
  #  it "should ignore a match if keys aren't identical" do
  #    @db.should_receive(:view).twice.and_return({
  #      "rows" => [{
  #          "key" => ["eur","Adidas","Nike","Samba","Dunk"],
  #          "value" => {"size_sum" => 2, "num_feet" => 2} }]
  #    }, {
  #      "rows" => []
  #    })
  #    matches = @foot.transposed_matches
  #    matches.should be_empty
  #  end
  #
  #
  #  it "should skip shoes without model name" do
  #    @db.should_receive(:view).once.and_return({
  #      "rows" => [{
  #          "key" => ["eur","Adidas","Nike","Samba","AF1"],
  #          "value" => {"size_sum" => 2, "num_feet" => 2} }]
  #    })
  #
  #    shoe_without_model_name = Shoe.new :manufacturer => "Rieker", :model => "", :sizes => {:eur => 45}
  #    @foot.shoes = [@samba, shoe_without_model_name]
  #
  #    matches = @foot.transposed_matches
  #    matches.size.should be_eql(1)
  #  end
  #end
  #
  #describe "when computing recommended shoes" do
  #  it "should yield one recommended shoe" do
  #    @samba.stub!(:recommended).and_return [RecommendationResult.new("Nike", "Air Max", 3)]
  #    @allstar.stub!(:recommended).and_return []
  #
  #    @foot.recommended_shoes.size.should eql(1)
  #    @foot.recommended_shoes.first.num_feet.should eql(3)
  #  end
  #  it "should merge same recommended shoes" do
  #    @samba.stub!(:recommended).and_return [RecommendationResult.new("Nike", "Air Max", 3)]
  #    @allstar.stub!(:recommended).and_return [RecommendationResult.new("Nike", "Air Max", 2)]
  #
  #    @foot.recommended_shoes.size.should eql(1)
  #    @foot.recommended_shoes.first.num_feet.should eql(5)
  #  end
  #end
end
