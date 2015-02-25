class DateFormatSelectorCell < Cell::Rails
  def show(args)
    @form = args[:form]
    @options = self.class.options

    render
  end

  private

  def self.options
    if @options
      @options
    else
      example_date = Date.parse '2010-02-15'
      @options = ['db', '%d %b %Y'].collect {|format| [example_date.strftime(DateFormat.new(format).to_s), format]}
    end
  end
end