require "test_helper"

class AgendaItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agenda_item = AgendaItem.create!(document: documents(:one))
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
      post agenda_items_url, params: { agenda_item: { document_id: documents(:one).id } }
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
    patch agenda_item_url(@agenda_item), params: { agenda_item: { start_time: Time.current.to_s, end_time: nil } }
    assert_redirected_to agenda_item_url(@agenda_item)
  end

  test "should destroy agenda_item" do
    assert_difference("AgendaItem.count", -1) do
      delete agenda_item_url(@agenda_item)
    end

    assert_redirected_to agenda_items_url
  end

  test "status behaves correctly" do
    ai = AgendaItem.new()

    assert_equal :todo, ai.status
    ai.validate
    assert ai.errors[:status].none?

    ai.start_time = Time.current
    assert_equal :doing, ai.status
    ai.validate
    assert ai.errors[:status].none?

    ai.end_time = Time.current + 1.hour
    assert_equal :done, ai.status
    ai.validate
    assert ai.errors[:status].none?

    ai.start_time = nil
    assert_equal :done, ai.status
    ai.validate
    assert ai.errors[:status].none?
  end
end
