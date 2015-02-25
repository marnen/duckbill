class DateFormat
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def format(date)
    date.strftime format_string
  end

  def to_s
    key
  end

  private

  def format_string
    @format_string ||= Date::DATE_FORMATS[key.to_sym] || key
  end
end