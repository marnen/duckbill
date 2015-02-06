module PathHelpers
  def path_to(page_name)
    case page_name
    when 'an invoice page'
      %r{^/invoices/[^/+]+$}
    when 'the user profile edit page'
      edit_user_registration_path
    when 'the user registration page'
      new_user_registration_path
    when /^the (.+)'s edit page$/
      model = $1.gsub(' ', '_')
      self.send "edit_#{model}_path", instance_variable_get("@#{model}")
    else
      begin
        path_helper = page_name.gsub(/\bpage$/, 'path').gsub(/^the /, '').gsub(' ', '_')
        self.send path_helper
      rescue NoMethodError
        raise ArgumentError, "Path to '#{page_name}' is not defined. Please add a mapping in #{__FILE__}."
      end
    end
  end
end

World PathHelpers