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
    Foot.similar_feet(@arbos_fuss).include?(@eckis_fuss).should be_true
  end
    
  it "should find shoe of the second foot" do
    @arbos_fuss.fitting_shoes.include?(@eckis_camper).should be_true
  end

end