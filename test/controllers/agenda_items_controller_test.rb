require "test_helper"

class AgendaItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agenda_item = agenda_items(:one)
  end

  test "should get index" do
    get agenda_items_url
    assert_response :success
  end

  test "should get new" do
    get new_agenda_item_url
    assert_response :success
  end

  test "should create agenda_item" do
    assert_difference("AgendaItem.count") do
      post agenda_items_url, params: { agenda_item: {} }
    end

    assert_redirected_to agenda_item_url(AgendaItem.last)
  end

  test "should show agenda_item" do
    get agenda_item_url(@agenda_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_agenda_item_url(@agenda_item)
    assert_response :success
  end

  test "should update agenda_item" do
    patch agenda_item_url(@agenda_item), params: { agenda_item: {} }
    assert_redirected_to agenda_item_url(@agenda_item)
  end

  test "should destroy agenda_item" do
    assert_difference("AgendaItem.count", -1) do
      delete agenda_item_url(@agenda_item)
    end

    assert_redirected_to agenda_items_url
  end
end
