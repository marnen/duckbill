class StateValidator < ActiveModel::Validations::LengthValidator
  def initialize(options)
    options.reverse_merge! is: 2, allow_nil: true, allow_blank: true
    super options
  end
end
