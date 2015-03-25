class CreateInvoiceService
  class << self
    def call(invoice)
      Invoice.transaction do
        invoice.capture_association_versions!
        invoice.save && TimeEntry.uninvoiced.where(project_id: invoice.project_id).update_all(invoice_id: invoice.id)
      end
    end
  end
end