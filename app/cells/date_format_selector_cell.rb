class DateFormatSelectorCell < Cell::ViewModel
  def show
    render
  end

  private

  def options
    self.class.options
  end

  def self.options
    if @options
      @options
    else
      example_date = Date.parse '2010-02-15'
      @options = ['db', '%d %b %Y'].collect {|format| [DateFormat.new(format).format(example_date), format]}
    end
  end
end