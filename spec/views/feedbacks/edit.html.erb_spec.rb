require 'spec_helper'

describe "/feedbacks/edit.html.erb" do
  include FeedbacksHelper

  before(:each) do
    assigns[:feedback] = @feedback = stub_model(Feedback,
      :new_record? => false
    )
  end

  it "renders the edit feedback form" do
    render

    response.should have_tag("form[action=#{feedback_path(@feedback)}][method=post]") do
    end
  end
end
