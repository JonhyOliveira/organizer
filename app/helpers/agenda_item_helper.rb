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

    tag.div class: [ "p-2 -translate-x-4" ] do
      tag.span class: [ "bg-#{status_class}", "text-#{status_class}-content", "px-2", "py-2", "rounded" ] do
        agenda_item.status.to_s.humanize
      end
    end
  end
end
