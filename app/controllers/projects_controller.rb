class ProjectsController < AuthenticatedController
  responders :collection, :flash
  respond_to :html
  skip_authorize_resource only: :new

  def index
    @has_clients = current_user.clients.first.present?
  end

  def new
  end

  def create
    @project.save
    standard_response
  end

  def edit
  end

  def update
    @project.update_attributes resource_params
    standard_response
  end

  private

  def resource_params
    params.require(:project).permit *Project.resource_params
  end

  def standard_response
    respond_with @project
  end
end