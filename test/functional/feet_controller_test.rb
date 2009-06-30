require 'test_helper'

class FeetControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feet)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create foot" do
    assert_difference('Foot.count') do
      post :create, :foot => { }
    end

    assert_redirected_to foot_path(assigns(:foot))
  end

  test "should show foot" do
    get :show, :id => feet(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => feet(:one).to_param
    assert_response :success
  end

  test "should update foot" do
    put :update, :id => feet(:one).to_param, :foot => { }
    assert_redirected_to foot_path(assigns(:foot))
  end

  test "should destroy foot" do
    assert_difference('Foot.count', -1) do
      delete :destroy, :id => feet(:one).to_param
    end

    assert_redirected_to feet_path
  end
end
