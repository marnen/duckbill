class InvoicesController < BaseController
  skip_authorize_resource only: :new

  def index
  end

  def new
  end

  def create
    CreateInvoiceService.call @invoice
    respond_with @invoice
  end

  def show
    @invoice = Invoice.with_time_entries.where(id: params[:id]).first
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