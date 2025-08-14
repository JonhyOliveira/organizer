require "application_system_test_case"

class AgendaItemsTest < ApplicationSystemTestCase
  setup do
    @agenda_item = agenda_items(:one)
  end

  test "visiting the index" do
    visit agenda_items_url
    assert_selector "h1", text: "Agenda items"
  end

  test "should create agenda item" do
    visit agenda_items_url
    click_on "New agenda item"

    click_on "Create Agenda item"

    assert_text "Agenda item was successfully created"
    click_on "Back"
  end

  test "should update Agenda item" do
    visit agenda_item_url(@agenda_item)
    click_on "Edit this agenda item", match: :first

    click_on "Update Agenda item"

    assert_text "Agenda item was successfully updated"
    click_on "Back"
  end

  test "should destroy Agenda item" do
    visit agenda_item_url(@agenda_item)
    accept_confirm { accept_confirm { click_on "Destroy this agenda item", match: :first } }

    assert_text "Agenda item was successfully destroyed"
  end
end
