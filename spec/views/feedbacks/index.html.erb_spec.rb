require 'spec_helper'

describe "/feedbacks/index.html.erb" do
  include FeedbacksHelper

  before(:each) do
    assigns[:feedbacks] = [
      stub_model(Feedback),
      stub_model(Feedback)
    ]
  end

  it "renders a list of feedbacks" do
    render
  end
end
