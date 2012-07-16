require 'test_helper'

class FriendCodesControllerTest < ActionController::TestCase
  setup do
    @friend_code = friend_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:friend_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create friend_code" do
    assert_difference('FriendCode.count') do
      post :create, :friend_code => @friend_code.attributes
    end

    assert_redirected_to friend_code_path(assigns(:friend_code))
  end

  test "should show friend_code" do
    get :show, :id => @friend_code.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @friend_code.to_param
    assert_response :success
  end

  test "should update friend_code" do
    put :update, :id => @friend_code.to_param, :friend_code => @friend_code.attributes
    assert_redirected_to friend_code_path(assigns(:friend_code))
  end

  test "should destroy friend_code" do
    assert_difference('FriendCode.count', -1) do
      delete :destroy, :id => @friend_code.to_param
    end

    assert_redirected_to friend_codes_path
  end
end
