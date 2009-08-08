require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Foot do

  fixtures :shoes, :feet
  
  before(:each) do
    @arbos_fuss = feet(:arbo)
    @eckis_fuss = feet(:ecki)
    @eckis_camper = shoes(:camper)
  end
  
  it "should find similar feet" do
    Foot.similar_feet(@arbos_fuss).should include(@eckis_fuss)
  end
    
  it "should find shoes of the similar feet" do
    @arbos_fuss.shoes_of_similar_feet.should include(@eckis_camper)
  end

  it "should recommend fitting shoes" do
    @arbos_fuss.fitting_shoes.select{ |shoe| 
      shoe.manufacturer == 'Camper' and shoe.model == 'Trabant'}.first.size.should == @eckis_camper.size
  end

  it "should recommend only one shoe-model" do
    @arbos_fuss.fitting_shoes.select{ |shoe| 
      shoe.model == 'Adi Racer High' }.size.should == 1
  end

  it "should yield a fitting shoe by model and manufacturer" do
    @arbos_fuss.fitting( :manufacturer => "Camper",  :model  => "Trabant" ).size.should == @eckis_camper.size
  end
  
  it "should compute average shoe size" do
    @arbos_fuss.fitting( :manufacturer => "Adidas",  :model  => "Adi Racer High" ).size.should == 46.5
  end

  it "should compute the average correctly" do
    @arbos_fuss.avg_of([1]).should == 1
    @arbos_fuss.avg_of([1,3]).should == 2
    @arbos_fuss.avg_of([5,2,3,4,1]).should == 3
    @arbos_fuss.avg_of([1,2,3,4,5,6]).should == 3.5
    @arbos_fuss.avg_of([3,4,4,4,5,10]).should == 5
    @arbos_fuss.avg_of([3,4,4,4,5,16]).should == 6
  end
    
  it "should compute the median correctly" do
    @arbos_fuss.median_of([1]).should == 1
    @arbos_fuss.median_of([1,3]).should == 2
    @arbos_fuss.median_of([5,2,3,4,1]).should == 3
    @arbos_fuss.median_of([1,2,3,4,5,6]).should == 3.5
    @arbos_fuss.median_of([3,4,4,4,5,10]).should == 4
    @arbos_fuss.median_of([3,4,4,4,5,16]).should == 4
  end

end