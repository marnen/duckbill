class CreateInvoiceService
  class << self
    def call(invoice)
      Invoice.transaction do
        invoice.capture_association_versions!
        invoice.save && TimeEntry.where(project_id: invoice.project_id, invoice_id: nil).update_all(invoice_id: invoice.id)
      end
    end
  end
end