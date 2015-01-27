class TimeEntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @time_entries = current_user.time_entries
  end

  def new
    @time_entry = TimeEntry.new
  end

  def create
    TimeEntry.create! params.require(:time_entry).permit(:date, :hours, :description, :notes).merge user: current_user
    redirect_to action: 'index' and return
  end

  def edit
    @time_entry = TimeEntry.find params[:id]
  end

  def update
    TimeEntry.find(params[:id]).update_attributes! params.require(:time_entry).permit(:date, :hours, :description, :notes)
    redirect_to action: 'index' and return
  end
end