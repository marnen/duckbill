class TimeEntriesController < AuthenticatedController
  responders :collection
  respond_to :html
  skip_authorize_resource only: :new

  def index
    @time_entries = current_user.time_entries.includes(:project)
  end

  def new
  end

  def create
    if @time_entry.save
      flash[:notice] = _ 'Your time entry was successfully created!'
    else
      flash[:alert] = _ 'Your time entry could not be saved.'
    end
    standard_response
  end

  def edit
  end

  def update
    if @time_entry.update_attributes resource_params
      flash[:notice] = _ 'Your time entry was successfully updated.'
    else
      flash[:alert] = _ 'Your time entry could not be saved.'
    end
    standard_response
  end

  def destroy
    @time_entry.destroy
    flash[:notice] = _ 'Your time entry was successfully deleted.'
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