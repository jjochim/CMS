require 'test_helper'

class OrderSeatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_seating = order_seatings(:one)
  end

  test "should get index" do
    get order_seatings_url
    assert_response :success
  end

  test "should get new" do
    get new_order_seating_url
    assert_response :success
  end

  test "should create order_seating" do
    assert_difference('OrderSeating.count') do
      post order_seatings_url, params: { order_seating: { order_id: @order_seating.order_id, seating_id: @order_seating.seating_id, ticked_id: @order_seating.ticked_id } }
    end

    assert_redirected_to order_seating_url(OrderSeating.last)
  end

  test "should show order_seating" do
    get order_seating_url(@order_seating)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_seating_url(@order_seating)
    assert_response :success
  end

  test "should update order_seating" do
    patch order_seating_url(@order_seating), params: { order_seating: { order_id: @order_seating.order_id, seating_id: @order_seating.seating_id, ticked_id: @order_seating.ticked_id } }
    assert_redirected_to order_seating_url(@order_seating)
  end

  test "should destroy order_seating" do
    assert_difference('OrderSeating.count', -1) do
      delete order_seating_url(@order_seating)
    end

    assert_redirected_to order_seatings_url
  end
end
