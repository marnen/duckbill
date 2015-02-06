class ProjectSelectorCell < Cell::Rails
  def show(args)
    @form = args[:form]
    user = args[:user]
    @clients_with_projects = user.clients.includes(:projects).joins(:projects).order { [name, projects.name] }

    render
  end
end