module RemoveSpacesHelper
  def remove_spaces(string)
    string.gsub ' ', '_'
  end
end

World RemoveSpacesHelper