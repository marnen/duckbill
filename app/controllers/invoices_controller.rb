class InvoicesController < AuthenticatedController
  respond_to :html
  skip_authorize_resource only: :new

  def index
  end

  def new
  end

  def create
    if create_invoice
      flash[:notice] = _ 'Your invoice was successfully created.'
    else
      flash[:error] = _ 'Your invoice could not be created.'
    end
    respond_with @invoice
  end

  def show
    @invoice = Invoice.where(id: params[:id]).joins { time_entries.outer }.joins { project.client }.first
    @client = @invoice.client.decorate
    @project = @invoice.project
    @user = current_user.decorate
    @time_entries = @invoice.time_entries

    respond_to do |format|
      format.html
      format.pdf do
        render_pdf
      end
    end
  end

  private

  def create_invoice
    @invoice.save && TimeEntry.where(project_id: @invoice.project_id, invoice_id: nil).update_all(invoice_id: @invoice.id)
  end

  def resource_params
    params.require(:invoice).permit :project_id
  end

  # TODO: This probably shouldn't be in the controller, but I'm not sure where it *should* be.
  def render_pdf
    Tempfile.open ["invoices-#{@invoice.id}", '.pdf'] do |file|
      render pdf: file.path, template: 'invoices/show.html.haml'
    end
  end
end