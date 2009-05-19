require 'test_helper'

class ShoesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shoes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shoe" do
    assert_difference('Shoe.count') do
      post :create, :shoe => { }
    end

    assert_redirected_to shoe_path(assigns(:shoe))
  end

  test "should show shoe" do
    get :show, :id => shoes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => shoes(:one).to_param
    assert_response :success
  end

  test "should update shoe" do
    put :update, :id => shoes(:one).to_param, :shoe => { }
    assert_redirected_to shoe_path(assigns(:shoe))
  end

  test "should destroy shoe" do
    assert_difference('Shoe.count', -1) do
      delete :destroy, :id => shoes(:one).to_param
    end

    assert_redirected_to shoes_path
  end
end
