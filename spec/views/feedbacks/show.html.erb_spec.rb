require 'spec_helper'

describe "/feedbacks/show.html.erb" do
  include FeedbacksHelper
  before(:each) do
    assigns[:feedback] = @feedback = stub_model(Feedback)
  end

  it "renders attributes in <p>" do
    render
  end
end
