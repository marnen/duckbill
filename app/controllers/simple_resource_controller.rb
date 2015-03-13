class SimpleResourceController < BaseController
  responders :collection

  private

  def create_params
    resource_params
  end

  def resource_class
    @resource_class = resource_class_name.constantize
  end

  def resource_class_name
    @resource_class_name = self.class.name.chomp('Controller').singularize
  end

  def resource_name
    @resource_name ||= resource_class_name.underscore
  end

  def resource_params
    params.require(resource_name).permit *resource_class.resource_params
  end

  def resource_response
    resource = instance_variable_get "@#{resource_name}"
    respond_with resource
  end

  def update_params
    resource_params
  end
end