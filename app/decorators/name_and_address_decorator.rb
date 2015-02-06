module NameAndAddressDecorator
  def name_and_address
    [model.name, model.company, model.email, model.street, city_state_zip].reject(&:blank?).join "\n"
  end

  private

  def city_state_zip
    if [model.city, model.state, model.zip].all? &:blank?
      nil
    else
      "#{model.city}, #{model.state} #{model.zip}"
    end
  end
end