require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Foot do

  fixtures :shoes, :feet, :shoe_types, :manufacturers
  
  before(:each) do
    @arbos_fuss = feet(:arbo)
    @eckis_fuss = feet(:ecki)
    @eckis_camper = shoes(:camper)
    @saschas_fuss = feet(:sascha)
  end
  
  it "should find similar feet" do
    Foot.similar_feet(@arbos_fuss).should include(@eckis_fuss)
  end
    
  it "should find shoes of the similar feet" do
    @arbos_fuss.shoes_of_similar_feet.should include(@eckis_camper)
  end

  it "should recommend fitting shoes" do
    @arbos_fuss.fitting_shoes.select{ |s| s.manufacturer == 'Camper' and s.model == 'Trabant'}.first.size.should == @eckis_camper.size
  end

  it "should recommend only one shoe-model" do
    @arbos_fuss.fitting_shoes.select{ |s| s.model == 'Adi Racer High' }.size.should == 1
  end

  it "should yield a fitting shoe by model and manufacturer" do
    @arbos_fuss.fitting( :manufacturer => "Camper",  :model  => "Trabant" ).size.should == @eckis_camper.size
  end
  
  it "should compute median shoe size" do
    @arbos_fuss.fitting( :manufacturer => "Adidas",  :model  => "Adi Racer High" ).size.should == 46.5
  end

  it "should compute the mean average of its shoes to suggest a shoe size of a shoe not found on other feet" do
    @arbos_fuss.fitting( :manufacturer => "Vans",  :model  => "Old Skool" ).size.should == 46
  end

  it "should convert a shoe size to match similar feet and find fitting shoes" do
    @saschas_fuss.fitting( :manufacturer => "Adidas",  :model  => "Adi Racer High" ).size.should == 44.5
  end
end