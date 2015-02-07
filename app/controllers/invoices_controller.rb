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
        Tempfile.open ["invoices-#{@invoice.id}", '.pdf'] do |file|
          render pdf: file.path, template: 'invoices/show.html.haml', layout: 'application.pdf.haml', print_media_type: true
        end
      end
    end
  end

  private

  def create_invoice
    @invoice.save && TimeEntry.where(project_id: @invoice.project_id).update_all(invoice_id: @invoice.id)
  end

  def resource_params
    params.require(:invoice).permit :project_id
  end
end