class ProjectLinkCell < Cell::Rails
  def show(args)
    @project = args[:invoice].snapshot :project
    render
  end
end
