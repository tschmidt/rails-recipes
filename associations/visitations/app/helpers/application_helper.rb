module ApplicationHelper
  
  def error_messages_for(obj)
    if obj && obj.errors.any?
      object_errors = obj.errors.full_messages.map { |msg| content_tag(:li, msg) }
      content_tag(:div, class: 'error-messages') do
        content_tag(:h3, "#{pluralize(obj.errors.count, 'error')} prohibited the #{obj.class.to_s.downcase} from being saved") +
        content_tag(:ul, object_errors.join("\n").html_safe)
      end
    end
  end
  
end
