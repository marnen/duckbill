class CreateInvoiceService
  class << self
    def call(invoice)
      @invoice = invoice
      Invoice.transaction do
        [:project, :client].each {|association| capture_version association}
        invoice.save && TimeEntry.where(project_id: invoice.project_id, invoice_id: nil).update_all(invoice_id: invoice.id)
      end
    end

    private

    # TODO: move this method to Invoice
    def capture_version(association)
      object = @invoice.send association
      object.touch_with_version
      @invoice["#{association}_version_id"] = object.versions.last.id
    end
  end
end