require 'test_helper'

class FriendRequestsControllerTest < ActionController::TestCase
  setup do
    @friend_request = friend_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friend_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friend_request" do
    assert_difference('FriendRequest.count') do
      post :create, :friend_request => @friend_request.attributes
    end

    assert_redirected_to friend_request_path(assigns(:friend_request))
  end

  test "should show friend_request" do
    get :show, :id => @friend_request.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @friend_request.to_param
    assert_response :success
  end

  test "should update friend_request" do
    put :update, :id => @friend_request.to_param, :friend_request => @friend_request.attributes
    assert_redirected_to friend_request_path(assigns(:friend_request))
  end

  test "should destroy friend_request" do
    assert_difference('FriendRequest.count', -1) do
      delete :destroy, :id => @friend_request.to_param
    end

    assert_redirected_to friend_requests_path
  end
end
