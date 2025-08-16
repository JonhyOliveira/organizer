require "test_helper"

class AgendaItemTest < ActiveSupport::TestCase
  test "invalid execution range" do
    ai1 = AgendaItem.new(
      start_time: "2023-10-01 12:00:00",
      end_time: "2023-10-01 11:00:00"
    )

    assert ai1.valid? == false
    assert ai1.errors[:end_time].any?
    assert_equal I18n.t("errors.messages.greater_than", count: I18n.t("terms.start_time")), ai1.errors[:end_time].first
  end

  test "invalid do by range" do
    ai2 = AgendaItem.new(
      do_by_start: "2023-10-01 12:00:00",
      do_by_end: "2023-10-01 11:00:00"
    )

    assert ai2.valid? == false
    assert ai2.errors[:do_by_end].any?
    assert_equal I18n.t("errors.messages.greater_than", count: ai2.do_by_start), ai2.errors[:do_by_end].first
  end

  test "valid execution and do by ranges" do
    ai3 = AgendaItem.new(
      start_time: "2023-10-01 10:00:00",
      end_time: "2023-10-01 12:00:00",
      do_by_start: "2023-10-01 09:00:00",
      do_by_end: "2023-10-01 11:00:00"
    )

    ai3.validate
    assert ai3.errors[:do_by_end].empty?
    assert ai3.errors[:end_time].empty?
  end

  test "belongs to document" do
    ai = AgendaItem.new(document: documents(:one))
    assert ai.valid?

    ai.document = nil
    assert_not ai.valid?
  end

  test "belongs to parent agenda item" do
    parent_ai = AgendaItem.create!(document: documents(:one))
    child_ai = AgendaItem.new(document: documents(:one), parent_agenda_item: parent_ai)

    assert child_ai.valid?
    assert_equal parent_ai, child_ai.parent_agenda_item
  end
end
