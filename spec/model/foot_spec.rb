require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Foot do

  fixtures :shoes, :feet
  
  before(:each) do
    
    @arbos_fuss = feet(:arbo)
    @eckis_fuss = feet(:ecki)
    @arbos_airforce = shoes(:airforce)
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
      shoe.manufacturer == 'Camper' and shoe.model == 'Trabant'}.first.should == @eckis_camper
  end

  it "should recommend only one shoe-model" do
    @arbos_fuss.fitting_shoes.select{ |shoe| 
      shoe.model == 'Adi Racer High' }.size.should == 1
  end
  
  it "should compute average shoe size" do
    @arbos_fuss.fitting_shoes.select{ |shoe| 
      shoe.model == 'Adi Racer High' }.first.size.should == 46.5
  end
  
end