class FoundationFormBuilder < ActionView::Helpers::FormBuilder
  def input_div(field_name, label: nil, type: nil)
    @template.content_tag :div, class: field_name do
      [
        label(field_name, label),
        input_for(field_name, type),
        error_div(field_name)
      ].compact.join("\n").html_safe
    end
  end

  private

  def error_div(field_name)
    error_messages = errors[field_name]
    if error_messages.present?
      @template.content_tag :div, class: :error do
        error_messages.join(@template.tag :br).html_safe
      end
    else
      nil
    end
  end

  def errors
    @errors ||= @object.errors
  end

  def input_for(field_name, type)
    type ||= infer_type field_name

    case type
    when :date
      date_field field_name
    when :email
      email_field(field_name)
    when :textarea
      text_area field_name
    else
      text_field field_name
    end
  end

  def infer_type(field_name)
    if field_name == :email
      :email
    else
      type_mappings = {text: :textarea}

      db_type = @object.column_for_attribute(field_name).type
      type_mappings[db_type] || db_type
    end
  end
end