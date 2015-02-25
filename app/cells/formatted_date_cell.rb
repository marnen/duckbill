class FormattedDateCell < Cell::Rails
  include Devise::Controllers::Helpers
  helper_method :current_user

  def show(args)
    args[:date].strftime current_user.date_format.to_s
  end
end