class FoundationFormBuilder < ActionView::Helpers::FormBuilder
  def input_div(field_name)
    @template.content_tag :div, class: field_name do
      [
        label(field_name),
        input_for(field_name),
        error_div(field_name)
      ].compact.join("\n").html_safe
    end
  end

  private

  def error_div(field_name)
    if error_message_on(field_name).present?
      @template.content_tag :div, class: :error do
        error_message_on field_name
      end
    else
      nil
    end
  end

  def input_for(field_name)
    case @object.column_for_attribute(field_name).type
    when :date
      date_field field_name
    when :text
      text_area field_name
    else
      text_field field_name
    end
  end
end