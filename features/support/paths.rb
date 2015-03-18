module PathHelpers
  def path_to(page_name)
    case page_name
    when 'an invoice page'
      %r{^/invoices/[^/+]+$}
    when "the invoice's project's page"
      project_path @invoice.project
    when 'the user profile edit page'
      edit_user_registration_path
    when 'the user registration page'
      new_user_registration_path
    when /^the (.+)'s page$/
      model_path $1
    when /^the (.+)'s edit page$/
      model_path $1, :edit
    else
      begin
        path_helper = page_name.gsub(/\bpage$/, 'path').gsub(/^the /, '').gsub(' ', '_')
        self.send path_helper
      rescue NoMethodError
        raise ArgumentError, "Path to '#{page_name}' is not defined. Please add a mapping in #{__FILE__}."
      end
    end
  end

  private

  def model_path(model, action = nil)
    model.gsub! ' ', '_'
    path = [action, model, 'path'].compact.join '_'
    self.send path, instance_variable_get("@#{model}")
  end
end

World PathHelpers