class AgendaItem < ApplicationRecord
  belongs_to :document
  belongs_to :parent_agenda_item, class_name: "AgendaItem", optional: true

  enum :status, { "todo" => "todo", "doing" => "doing", "done" => "done" }

  validate :do_by_range_valid
  validate :execution_range_valid

  delegate :title, :description, to: :document

  before_validation :set_status

  def execution_range
    start_time..end_time
  end

  def do_by_range
    do_by_start..do_by_end
  end

  def set_status
    self.status = _status
  end

  private

  def _status
    return :todo if execution_range.begin.nil? && execution_range.end.nil?

    if execution_range.end.present?
      :done
    else
      :doing
    end
  end

  def do_by_range_valid
    return unless do_by_start.present?
    return unless do_by_end.present?

    errors.add(:do_by_end, I18n.t("errors.messages.greater_than", count: do_by_start)) if do_by_start > do_by_end
  end

    def execution_range_valid
    return unless start_time.present?
    return unless end_time.present?

    errors.add(:end_time, I18n.t("errors.messages.greater_than", count: I18n.t("terms.start_time"))) if start_time > end_time
    errors.add(:start_time, I18n.t("errors.messages.cant_be_in_the_future")) if start_time.future?
  end
end
