class ProjectSelectorCell < Cell::Rails
  def show(args)
    @form = args[:form]
    user = args[:user]
    @clients_with_projects = user.clients.includes(:projects).order(:name, "#{Project.table_name}.name")

    render
  end
end