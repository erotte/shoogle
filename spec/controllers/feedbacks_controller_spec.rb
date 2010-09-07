require 'spec_helper'

describe FeedbacksController do

  def mock_feedback(stubs={})
    @mock_feedback ||= mock_model(Feedback, stubs)
  end

  describe "GET index" do
    it "assigns all feedbacks as @feedbacks" do
      Feedback.stub(:find).with(:all).and_return([mock_feedback])
      get :index
      assigns[:feedbacks].should == [mock_feedback]
    end
  end

  describe "GET show" do
    it "assigns the requested feedback as @feedback" do
      Feedback.stub(:find).with("37").and_return(mock_feedback)
      get :show, :id => "37"
      assigns[:feedback].should equal(mock_feedback)
    end
  end

  describe "GET new" do
    it "assigns a new feedback as @feedback" do
      Feedback.stub(:new).and_return(mock_feedback)
      get :new
      assigns[:feedback].should equal(mock_feedback)
    end
  end

  describe "GET edit" do
    it "assigns the requested feedback as @feedback" do
      Feedback.stub(:find).with("37").and_return(mock_feedback)
      get :edit, :id => "37"
      assigns[:feedback].should equal(mock_feedback)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created feedback as @feedback" do
        Feedback.stub(:new).with({'these' => 'params'}).and_return(mock_feedback(:save => true))
        post :create, :feedback => {:these => 'params'}
        assigns[:feedback].should equal(mock_feedback)
      end

      it "redirects to the created feedback" do
        Feedback.stub(:new).and_return(mock_feedback(:save => true))
        post :create, :feedback => {}
        response.should redirect_to(feedback_url(mock_feedback))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved feedback as @feedback" do
        Feedback.stub(:new).with({'these' => 'params'}).and_return(mock_feedback(:save => false))
        post :create, :feedback => {:these => 'params'}
        assigns[:feedback].should equal(mock_feedback)
      end

      it "re-renders the 'new' template" do
        Feedback.stub(:new).and_return(mock_feedback(:save => false))
        post :create, :feedback => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested feedback" do
        Feedback.should_receive(:find).with("37").and_return(mock_feedback)
        mock_feedback.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :feedback => {:these => 'params'}
      end

      it "assigns the requested feedback as @feedback" do
        Feedback.stub(:find).and_return(mock_feedback(:update_attributes => true))
        put :update, :id => "1"
        assigns[:feedback].should equal(mock_feedback)
      end

      it "redirects to the feedback" do
        Feedback.stub(:find).and_return(mock_feedback(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(feedback_url(mock_feedback))
      end
    end

    describe "with invalid params" do
      it "updates the requested feedback" do
        Feedback.should_receive(:find).with("37").and_return(mock_feedback)
        mock_feedback.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :feedback => {:these => 'params'}
      end

      it "assigns the feedback as @feedback" do
        Feedback.stub(:find).and_return(mock_feedback(:update_attributes => false))
        put :update, :id => "1"
        assigns[:feedback].should equal(mock_feedback)
      end

      it "re-renders the 'edit' template" do
        Feedback.stub(:find).and_return(mock_feedback(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested feedback" do
      Feedback.should_receive(:find).with("37").and_return(mock_feedback)
      mock_feedback.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the feedbacks list" do
      Feedback.stub(:find).and_return(mock_feedback(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(feedbacks_url)
    end
  end

end
