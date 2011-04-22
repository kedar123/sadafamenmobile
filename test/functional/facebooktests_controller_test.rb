require 'test_helper'

class FacebooktestsControllerTest < ActionController::TestCase
  setup do
    @facebooktest = facebooktests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facebooktests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facebooktest" do
    assert_difference('Facebooktest.count') do
      post :create, :facebooktest => @facebooktest.attributes
    end

    assert_redirected_to facebooktest_path(assigns(:facebooktest))
  end

  test "should show facebooktest" do
    get :show, :id => @facebooktest.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @facebooktest.to_param
    assert_response :success
  end

  test "should update facebooktest" do
    put :update, :id => @facebooktest.to_param, :facebooktest => @facebooktest.attributes
    assert_redirected_to facebooktest_path(assigns(:facebooktest))
  end

  test "should destroy facebooktest" do
    assert_difference('Facebooktest.count', -1) do
      delete :destroy, :id => @facebooktest.to_param
    end

    assert_redirected_to facebooktests_path
  end
end
