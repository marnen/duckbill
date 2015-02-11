Then 'I should see the invoice number' do
  expect(page).to have_selector '.invoice-number', text: (@invoice || Invoice.last).id # TODO: we really shouldn't use the ID as the invoice number
end