class CreateInvoiceService
  def self.call(invoice)
    Invoice.transaction do
      project = invoice.project
      project.touch_with_version
      invoice.project_version_id = project.versions.last.try :id

      client = invoice.client
      client.touch_with_version
      invoice.client_version_id = client.versions.last.try :id

      invoice.save && TimeEntry.where(project_id: invoice.project_id, invoice_id: nil).update_all(invoice_id: invoice.id)
    end
  end
end