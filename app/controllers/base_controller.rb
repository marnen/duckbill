class BaseController < ApplicationController
  before_action :authenticate_user!
  around_action :set_time_zone
  load_and_authorize_resource

  responders :flash
  respond_to :html

  private

  # Stolen right from the Rails docs. :)
  def set_time_zone
    Time.use_zone(current_user.time_zone) { yield }
  end
end