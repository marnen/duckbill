class ClientsController < ApplicationController
  load_and_authorize_resource
  respond_to :html

  def index
  end

  def new
  end

  def create
    @client.save
    standard_response
  end

  def edit
  end

  def update
    @client.update_attributes update_params
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
    params.require(:client).permit(:name, :company, :email, :street, :city, :state, :zip)
  end
end