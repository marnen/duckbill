class TimeEntriesController < SimpleResourceController
  skip_authorize_resource only: :new

  def index
    @time_entries = current_user.time_entries.includes(:project)
  end

  def new
  end

  def create
    @time_entry.save
    resource_response
  end

  def edit
  end

  def update
    @time_entry.update_attributes resource_params
    resource_response
  end

  def destroy
    @time_entry.destroy
    resource_response
  end
end