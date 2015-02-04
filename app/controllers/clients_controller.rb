class ClientsController < AuthenticatedController
  respond_to :html

  def index
  end

  def new
  end

  def create
    @client.save
    flash[:notice] = _ 'Client was successfully created!'
    standard_response
  end

  def edit
  end

  def update
    @client.update_attributes update_params
    flash[:notice] = _ 'Client was successfully updated.'
    standard_response
  end

  private

  def create_params
    update_params.merge user_id: current_user.id
  end

  def standard_response
    respond_with @client, location: clients_path
  end

  def update_params
    params.require(:client).permit *Client.resource_params
  end
end