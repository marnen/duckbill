class ClientSelectorCell < Cell::Rails
  include Devise::Controllers::Helpers
  helper_method :current_user

  def show(args)
    @form = args[:form]
    @clients = current_user.clients

    render
  end
end