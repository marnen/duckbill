class FormattedDateCell < Cell::ViewModel
  include Devise::Controllers::Helpers
  helper_method :current_user

  def show
    date.strftime current_user.date_format.to_s
  end
end