require 'test_helper'

class FriendControllerTest < ActionController::TestCase
  test "should get friend_product" do
    get :friend_product
    assert_response :success
  end

end
