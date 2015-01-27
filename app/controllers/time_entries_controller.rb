class TimeEntriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @time_entries = current_user.time_entries
  end

  def new
  end

  def create
    @time_entry.save!
    redirect_to action: 'index' and return
  end

  def edit
  end

  def update
    @time_entry.update_attributes update_params
    redirect_to action: 'index' and return
  end

  private

  def create_params
    update_params.merge user: current_user
  end

  def update_params
    params.require(:time_entry).permit(:date, :hours, :description, :notes)
  end
end