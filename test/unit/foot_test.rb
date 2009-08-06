require 'test_helper'

class FootTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  fixtures :shoes, :feet

  def setup
    @arbos_fuss = feet(:arbo)
    @eckis_fuss = feet(:ecki)
    @arbos_airforce = shoes(:airforce)
    @eckis_camper = shoes(:camper)
    
  end  

  test "should find similar feet" do
    assert Foot.similar_feet(@arbos_fuss).include?(@eckis_fuss)
  end


  test "should find shoe of the second foot" do
    assert @arbos_fuss.fitting_shoes.include?(@eckis_camper)
  end
  
  test "should find shoe of the second foot" do
    assert @arbos_fuss.fitting_shoes.include?(@eckis_camper)
  end
  
end
