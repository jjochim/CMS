require 'test_helper'

class OrderTicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_ticket = order_tickets(:one)
  end

  test "should get index" do
    get order_tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_order_ticket_url
    assert_response :success
  end

  test "should create order_ticket" do
    assert_difference('OrderTicket.count') do
      post order_tickets_url, params: { order_ticket: { order_id: @order_ticket.order_id, ticked_id: @order_ticket.ticked_id } }
    end

    assert_redirected_to order_ticket_url(OrderTicket.last)
  end

  test "should show order_ticket" do
    get order_ticket_url(@order_ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_ticket_url(@order_ticket)
    assert_response :success
  end

  test "should update order_ticket" do
    patch order_ticket_url(@order_ticket), params: { order_ticket: { order_id: @order_ticket.order_id, ticked_id: @order_ticket.ticked_id } }
    assert_redirected_to order_ticket_url(@order_ticket)
  end

  test "should destroy order_ticket" do
    assert_difference('OrderTicket.count', -1) do
      delete order_ticket_url(@order_ticket)
    end

    assert_redirected_to order_tickets_url
  end
end
