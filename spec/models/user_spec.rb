require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
       :agb_accept => true,
       :email => "aaa@bbb.de"
    }
  end

  it "should validate agb_accept and email" do
    user =User.new(@valid_attributes)
    user.should be_valid
  end

  it "should validate missing agb_accept and email" do
     user =User.new
     user.should_not be_valid
     user.agb_accept= @valid_attributes[:agb_accept]
     user.should_not be_valid
     user.email= @valid_attributes[:email]
     user.should be_valid
   end

  it "should check for blacklisted domain" do
    user = User.new(@valid_attributes.merge(:email => 'blacklisted@trashmail.net'))
    user.should_not be_valid
   end


end
