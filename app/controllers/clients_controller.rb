class ClientsController < SimpleResourceController
  def index
  end

  def show
  end

  def new
  end

  def create
    @client.save
    resource_response
  end

  def edit
  end

  def update
    @client.update_attributes update_params
    resource_response
  end

  private

  def create_params
    resource_params.merge user_id: current_user.id
  end
end