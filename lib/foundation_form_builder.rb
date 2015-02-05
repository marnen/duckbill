class FoundationFormBuilder < ActionView::Helpers::FormBuilder
  def input_div(field_name, label: nil, type: nil, field: {})
    @template.content_tag :div, class: field_name do
      [
        label(field_name, label),
        input_for(field_name, type, field),
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

  def input_for(field_name, type, field_options)
    type ||= infer_type field_name

    method_mappings = {
      date: :date_field,
      email: :email_field,
      password: :password_field,
      textarea: :text_area
    }

    field_method = method_mappings[type] || :text_field

    self.send field_method, field_name, field_options
  end

  def infer_type(field_name)
    case field_name
    when :email
      :email
    when %r{(\b|_)password(\b|_)}
      :password
    else
      type_mappings = {text: :textarea}

      db_type = @object.column_for_attribute(field_name).type
      type_mappings[db_type] || db_type
    end
  end
end