class ProjectsController < AuthenticatedController
  respond_to :html
  skip_authorize_resource only: :new

  def index
  end

  def new
    @clients = current_user.clients.order :name
  end

  def create
    if @project.save
      flash[:notice] = _ 'Your project was successfully created!'
    else
      flash[:error] = _ 'Your project could not be saved.'
    end
    respond_with @project, location: projects_path
  end

  private

  def resource_params
    params.require(:project).permit(:client_id, :name)
  end
end