module SelectorHelpers
  def selector_for(selector)
    case selector
    when 'the signup form'
      'form.new_user'
    else
      raise ArgumentError, "Selector '#{selector}' is not defined. Please add a mapping in #{__FILE__}."
    end
  end
end

World SelectorHelpers