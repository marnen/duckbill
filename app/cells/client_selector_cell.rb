class ClientSelectorCell < Cell::Rails
  def show(args)
    @form = args[:form]
    user = args[:user]
    @clients = user.clients

    render
  end
end