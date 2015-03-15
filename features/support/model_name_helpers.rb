module ModelNameHelpers
  def class_for(string)
    normalize(string).camelize.constantize
  end

  def singular_model_names
    @singular_model_names ||= glob_regexp raw_model_names
  end

  def model_names
    @model_names ||= glob_regexp(raw_model_names + raw_plural_model_names)
  end

  def normalize(string)
    remove_spaces(string).downcase.singularize
  end

  def plural_model_names
    @plural_model_names ||= glob_regexp raw_plural_model_names
  end

  private

  def glob_regexp(names)
    Regexp.new names.collect {|name| Regexp.escape name }.join '|'
  end

  def raw_model_names
    @raw_model_names ||= Dir[File.join(Rails.root, 'app', 'models', '**', '*.rb')].collect {|file| File.basename(file, '.*').gsub '_', ' ' }
  end

  def raw_plural_model_names
    @raw_plural_model_names ||= raw_model_names.collect &:pluralize
  end
end

World ModelNameHelpers