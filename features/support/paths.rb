module PathHelpers
  def path_to(page_name)
    case page_name
    when 'the user registration page'
      new_user_registration_path
    when /^the (.+)'s edit page$/
      model = $1.gsub(' ', '_')
      self.send "edit_#{model}_path", instance_variable_get("@#{model}")
    else
      begin
        path_helper = page_name.gsub(/\bpage$/, 'path').gsub(/^the /, '').gsub(' ', '_')
        warn "Automatically parsing '#{page_name}' as #{path_helper}. If this is not what you want, then add an explicit mapping in #{__FILE__} instead."
        self.send path_helper
      rescue NoMethodError
        raise ArgumentError, "Path to '#{page_name}' is not defined. Please add a mapping in #{__FILE__}."
      end
    end
  end
end

World PathHelpers