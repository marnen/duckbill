class CreateInvoiceService
  def self.call(invoice)
    invoice.save && TimeEntry.where(project_id: invoice.project_id, invoice_id: nil).update_all(invoice_id: invoice.id)
  end
end