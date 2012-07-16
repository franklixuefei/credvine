require 'test_helper'

class TempTableForCustsControllerTest < ActionController::TestCase
  setup do
    @temp_table_for_cust = temp_table_for_custs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:temp_table_for_custs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create temp_table_for_cust" do
    assert_difference('TempTableForCust.count') do
      post :create, :temp_table_for_cust => @temp_table_for_cust.attributes
    end

    assert_redirected_to temp_table_for_cust_path(assigns(:temp_table_for_cust))
  end

  test "should show temp_table_for_cust" do
    get :show, :id => @temp_table_for_cust.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @temp_table_for_cust.to_param
    assert_response :success
  end

  test "should update temp_table_for_cust" do
    put :update, :id => @temp_table_for_cust.to_param, :temp_table_for_cust => @temp_table_for_cust.attributes
    assert_redirected_to temp_table_for_cust_path(assigns(:temp_table_for_cust))
  end

  test "should destroy temp_table_for_cust" do
    assert_difference('TempTableForCust.count', -1) do
      delete :destroy, :id => @temp_table_for_cust.to_param
    end

    assert_redirected_to temp_table_for_custs_path
  end
end
