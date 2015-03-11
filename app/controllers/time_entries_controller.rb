class TimeEntriesController < AuthenticatedController
  responders :collection, :flash
  respond_to :html
  skip_authorize_resource only: :new

  def index
    @time_entries = current_user.time_entries.includes(:project)
  end

  def new
  end

  def create
    @time_entry.save
    standard_response
  end

  def edit
  end

  def update
    @time_entry.update_attributes resource_params
    standard_response
  end

  def destroy
    @time_entry.destroy
    standard_response
  end

  private

  def resource_params
    params.require(:time_entry).permit *TimeEntry.resource_params
  end

  def standard_response
    respond_with @time_entry
  end
end