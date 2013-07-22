require 'test_helper'

class NotificationControllerTest < ActionController::TestCase
  test "should get all_noti" do
    get :all_noti
    assert_response :success
  end

  test "should get message_noti" do
    get :message_noti
    assert_response :success
  end

  test "should get activity_noti" do
    get :activity_noti
    assert_response :success
  end

  test "should get post_noti" do
    get :post_noti
    assert_response :success
  end

end
