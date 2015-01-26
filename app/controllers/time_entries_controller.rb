class TimeEntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @time_entries = TimeEntry.all
  end

  def new
    @time_entry = TimeEntry.new
  end

  def create
    TimeEntry.create! params.require(:time_entry).permit(:date, :hours, :description, :notes).merge user: current_user
    redirect_to action: 'index' and return
  end
end