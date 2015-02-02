class TimeEntriesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  respond_to :html

  def index
    @time_entries = current_user.time_entries
  end

  def new
  end

  def create
    if @time_entry.save
      flash[:notice] = _ 'Your time entry was successfully created!'
    else
      flash[:alert] = (_ 'Your time entry could not be saved.')
    end
    standard_response
  end

  def edit
  end

  def update
    @time_entry.update_attributes update_params
    standard_response
  end

  def destroy
    @time_entry.destroy
    standard_response
  end

  private

  def create_params
    update_params.merge user: current_user
  end

  def standard_response
    respond_with @time_entry, location: time_entries_path
  end

  def update_params
    params.require(:time_entry).permit *TimeEntry.resource_params
  end
end