module StringHelpers
  def string_for(identifier)
    case identifier
    when 'the invoice number'
      @invoice.number
    when "the invoice's project's name"
      @invoice.project.name
    when "the project's name"
      @project.name
    when "the project's client's name"
      @project.client.name
    else
      raise ArgumentError, "String identifier '#{identifier}' is not defined. Please add a mapping in #{__FILE__}."
    end
  end
end

World StringHelpers