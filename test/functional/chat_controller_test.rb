require 'test_helper'

class ChatControllerTest < ActionController::TestCase
  test "should get chat_message" do
    get :chat_message
    assert_response :success
  end

  test "should get chat_side" do
    get :chat_side
    assert_response :success
  end

end
