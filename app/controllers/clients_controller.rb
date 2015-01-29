class ClientsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  def index
  end

  def new
  end

  def create
    @client.save
    respond_with @client, location: clients_path
  end

  private

  def resource_params
    params.require(:client).permit(:name, :company, :email, :street, :city, :state, :zip).merge user_id: current_user.id
  end
end