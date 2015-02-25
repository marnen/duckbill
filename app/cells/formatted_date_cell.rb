class FormattedDateCell < Cell::ViewModel
  include Devise::Controllers::Helpers
  helper_method :current_user

  def show
    current_user.date_format.format date
  end
end