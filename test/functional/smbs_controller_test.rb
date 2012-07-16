require 'test_helper'

class SmbsControllerTest < ActionController::TestCase
  test "should get redemption" do
    get :redemption
    assert_response :success
  end

end
