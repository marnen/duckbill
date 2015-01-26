module PathHelpers
  def path_to(page_name)
    case page_name
    when 'the work log page'
      time_entries_path
    else
      raise ArgumentError, "'#{page_name}' is not defined. Please add a mapping in #{__FILE__}."
    end
  end
end

World PathHelpers