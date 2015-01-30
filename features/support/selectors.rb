module SelectorHelpers
  def selector_for(element)
    case element
    when 'any time entries'
      '.time_entry'
    when 'the navigation bar'
      'nav.top-bar'
    when 'the signup form'
      'form.new_user'
    when /^the (.+) table$/
      "table.#{$1.gsub ' ', '_'}"
    else
      raise ArgumentError, "Selector '#{element}' is not defined. Please add a mapping in #{__FILE__}."
    end
  end
end

World SelectorHelpers