require 'test_helper'

class RejectFriendsControllerTest < ActionController::TestCase
  setup do
    @reject_friend = reject_friends(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reject_friends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reject_friend" do
    assert_difference('RejectFriend.count') do
      post :create, :reject_friend => @reject_friend.attributes
    end

    assert_redirected_to reject_friend_path(assigns(:reject_friend))
  end

  test "should show reject_friend" do
    get :show, :id => @reject_friend.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @reject_friend.to_param
    assert_response :success
  end

  test "should update reject_friend" do
    put :update, :id => @reject_friend.to_param, :reject_friend => @reject_friend.attributes
    assert_redirected_to reject_friend_path(assigns(:reject_friend))
  end

  test "should destroy reject_friend" do
    assert_difference('RejectFriend.count', -1) do
      delete :destroy, :id => @reject_friend.to_param
    end

    assert_redirected_to reject_friends_path
  end
end
