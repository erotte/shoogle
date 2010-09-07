require 'spec_helper'

describe "/feedbacks/new.html.erb" do
  include FeedbacksHelper

  before(:each) do
    assigns[:feedback] = stub_model(Feedback,
      :new_record? => true
    )
  end

  it "renders new feedback form" do
    render

    response.should have_tag("form[action=?][method=post]", feedbacks_path) do
    end
  end
end
