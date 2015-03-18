class ProjectsController < SimpleResourceController
  skip_authorize_resource only: :new

  def index
    @has_clients = current_user.clients.first.present?
  end

  def show
  end

  def new
  end

  def create
    @project.save
    resource_response
  end

  def edit
  end

  def update
    @project.update_attributes resource_params
    resource_response
  end
end