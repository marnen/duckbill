Then 'I should see the invoice number' do
  within '.invoice-number' do
    expect(page).to have_content Invoice.last.id # TODO: we really shouldn't use the ID as the invoice number
  end
end