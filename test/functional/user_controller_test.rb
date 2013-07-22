require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get my_search" do
    get :my_search
    assert_response :success
  end

  test "should get evaluation" do
    get :evaluation
    assert_response :success
  end

  test "should get my_info" do
    get :my_info
    assert_response :success
  end

  test "should get preference" do
    get :preference
    assert_response :success
  end

end
