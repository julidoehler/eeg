require 'test_helper'

class SidepicsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sidepics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sidepic" do
    assert_difference('Sidepic.count') do
      post :create, :sidepic => { }
    end

    assert_redirected_to sidepic_path(assigns(:sidepic))
  end

  test "should show sidepic" do
    get :show, :id => sidepics(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => sidepics(:one).to_param
    assert_response :success
  end

  test "should update sidepic" do
    put :update, :id => sidepics(:one).to_param, :sidepic => { }
    assert_redirected_to sidepic_path(assigns(:sidepic))
  end

  test "should destroy sidepic" do
    assert_difference('Sidepic.count', -1) do
      delete :destroy, :id => sidepics(:one).to_param
    end

    assert_redirected_to sidepics_path
  end
end
