module SelectorHelpers
  def selector_for(element)
    case element
    when 'any time entries'
      '.time_entry'
    when 'the invoice date'
      '.invoice-date'
    when 'the invoice sender'
      '.invoice .user'
    when 'the navigation bar'
      'nav.top-bar'
    when 'the signup form'
      'form.user'
    when /^the (.+) table$/
      "table.#{$1.gsub ' ', '_'}"
    else
      raise ArgumentError, "Selector '#{element}' is not defined. Please add a mapping in #{__FILE__}."
    end
  end
end

World SelectorHelpers