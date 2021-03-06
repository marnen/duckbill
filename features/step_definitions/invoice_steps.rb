Given 'I have an invoice for the project' do
  @invoice = FactoryGirl.build :invoice, project: @project
  CreateInvoiceService.call @invoice
end

Given 'I have an invoice for the project with the following time entry:' do |table|
  @invoice = FactoryGirl.create :invoice, project: @project
  @time_entry = FactoryGirl.create :time_entry, table.hashes.first.merge(project: @project, invoice: @invoice)
end

Then 'I should see the invoice number' do
  expect(page).to have_selector '.invoice-number', text: (@invoice || Invoice.last).number
end