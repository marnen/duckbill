class DateFormat
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def to_s
    @to_s ||= Date::DATE_FORMATS[@key.to_sym] || @key
  end
end