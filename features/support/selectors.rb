module SelectorHelpers
  def selector_for(selector)
    case selector
    when 'any time entries'
      '.time_entry'
    when 'the navigation bar'
      'nav.top-bar'
    when 'the signup form'
      'form.new_user'
    when 'the time entries table'
      'table.time_entries'
    else
      raise ArgumentError, "Selector '#{selector}' is not defined. Please add a mapping in #{__FILE__}."
    end
  end
end

World SelectorHelpers