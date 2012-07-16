require 'test_helper'

class TemptextsControllerTest < ActionController::TestCase
  setup do
    @temptext = temptexts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:temptexts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create temptext" do
    assert_difference('Temptext.count') do
      post :create, :temptext => @temptext.attributes
    end

    assert_redirected_to temptext_path(assigns(:temptext))
  end

  test "should show temptext" do
    get :show, :id => @temptext.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @temptext.to_param
    assert_response :success
  end

  test "should update temptext" do
    put :update, :id => @temptext.to_param, :temptext => @temptext.attributes
    assert_redirected_to temptext_path(assigns(:temptext))
  end

  test "should destroy temptext" do
    assert_difference('Temptext.count', -1) do
      delete :destroy, :id => @temptext.to_param
    end

    assert_redirected_to temptexts_path
  end
end
