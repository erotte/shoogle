require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
            :agb_accept => true,
            :email => "aaa@bbb.de",
            :password => 'geheim',
            :password_confirmation => 'geheim'
    }
  end

  it "should validate" do
    user = User.new(@valid_attributes)
    user.should be_valid
  end

  it "should validate missing agb_accept and email" do
    User.new(@valid_attributes.merge(:agb_accept => nil)).should_not be_valid
    User.new(@valid_attributes.merge(:email => "")).should_not be_valid
  end

  it "should validate password and confirmation" do
    User.new(@valid_attributes.merge(:password => "")).should_not be_valid
    User.new(@valid_attributes.merge(:password => "bla", :password_confirmation => "blubb")).should_not be_valid
  end

  it "should check email for blacklisted domain" do
    user = User.new(@valid_attributes.merge(:email => 'blacklisted@trashmail.net'))
    user.should_not be_valid
  end


end
