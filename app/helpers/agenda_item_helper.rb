module AgendaItemHelper
  def agenda_status_tag_for(agenda_item)
    agenda_status_tag_for_status(agenda_item.status)
  end

  def agenda_status_tag_for_status(status)
    status_class = agenda_status_class_for_status(status)

    tag.div class: [ "p-2" ] do
      tag.span class: [ "badge", "badge-#{status_class}", "rounded" ] do
        status.to_s.humanize
      end
    end
  end

  def agenda_status_class_for_status(status)
    case status.to_sym
    when :todo
      "error"
    when :doing
      "info"
    when :done
      "success"
    else
      "warning"
    end
  end
end
