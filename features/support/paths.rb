module PathHelpers
  def path_to(page_name)
    case page_name
    when 'the user registration page'
      new_user_registration_path
    when 'the work log page'
      time_entries_path
    else
      begin
        self.send page_name.gsub(/\bpage$/, 'path').gsub(/^the /, '').gsub(' ', '_')
      rescue NoMethodError
        raise ArgumentError, "'#{page_name}' is not defined. Please add a mapping in #{__FILE__}."
      end
    end
  end
end

World PathHelpers