module AgendaItemHelper
  def agenda_status_tag_for(agenda_item)
    status_class = case agenda_item.status.to_sym
    when :todo
      "error"
    when :doing
      "info"
    when :done
      "success"
    else
      "warning"
    end

    tag.div class: [ "p-2" ] do
      tag.span class: [ "badge", "badge-#{status_class}", "rounded" ] do
        agenda_item.status.to_s.humanize
      end
    end
  end
end
