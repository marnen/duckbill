class ApplicationController < ActionController::Base
  before_filter :set_gettext_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    [:sign_up, :account_update].each do |action|
      User.resource_parameters.each do |field|
        devise_parameter_sanitizer.for(action) << field
      end
    end
  end
end
