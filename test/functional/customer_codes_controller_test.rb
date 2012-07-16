require 'test_helper'

class CustomerCodesControllerTest < ActionController::TestCase
  setup do
    @customer_code = customer_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_code" do
    assert_difference('CustomerCode.count') do
      post :create, :customer_code => @customer_code.attributes
    end

    assert_redirected_to customer_code_path(assigns(:customer_code))
  end

  test "should show customer_code" do
    get :show, :id => @customer_code.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @customer_code.to_param
    assert_response :success
  end

  test "should update customer_code" do
    put :update, :id => @customer_code.to_param, :customer_code => @customer_code.attributes
    assert_redirected_to customer_code_path(assigns(:customer_code))
  end

  test "should destroy customer_code" do
    assert_difference('CustomerCode.count', -1) do
      delete :destroy, :id => @customer_code.to_param
    end

    assert_redirected_to customer_codes_path
  end
end
