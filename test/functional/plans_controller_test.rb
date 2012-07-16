require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  test "should get name:string" do
    get :name:string
    assert_response :success
  end

  test "should get price:decimal" do
    get :price:decimal
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
