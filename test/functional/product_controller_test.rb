require 'test_helper'

class ProductControllerTest < ActionController::TestCase
  test "should get seller_info" do
    get :seller_info
    assert_response :success
  end

  test "should get sell_product" do
    get :sell_product
    assert_response :success
  end

  test "should get product_list" do
    get :product_list
    assert_response :success
  end

end
