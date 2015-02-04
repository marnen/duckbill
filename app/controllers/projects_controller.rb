class ProjectsController < AuthenticatedController
  respond_to :html
  skip_authorize_resource only: :new

  def index
    @has_clients = current_user.clients.first.present?
  end

  def new
  end

  def create
    if @project.save
      flash[:notice] = _ 'Your project was successfully created!'
    else
      flash[:error] = _ 'Your project could not be saved.'
    end
    standard_response
  end

  def edit
  end

  def update
    if @project.update_attributes resource_params
      flash[:notice] = _ 'Your project was successfully updated.'
    else
      flash[:error] = _ 'Your project could not be saved.'
    end
    standard_response
  end

  private

  def resource_params
    params.require(:project).permit(:client_id, :name)
  end

  def standard_response
    respond_with @project, location: projects_path
  end
end