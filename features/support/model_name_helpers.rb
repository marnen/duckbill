module ModelNameHelpers
  def class_for(string)
    normalize(string).camelize.constantize
  end

  def normalize(string)
    remove_spaces(string).downcase.singularize
  end

  def remove_spaces(string)
    string.gsub ' ', '_'
  end
end

World ModelNameHelpers