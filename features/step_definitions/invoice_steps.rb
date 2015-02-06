Given 'I have an invoice' do
  @invoice = FactoryGirl.create :invoice, user: @current_user
end

Given 'I have the following invoice:' do |table|
  hash = table.hashes.first
  if hash['project']
    hash['project'] = @current_user.projects.find_by_name(hash['project']) || FactoryGirl.create(:project, user: @current_user, name: hash['project'])
  else
    hash['user'] = @current_user
  end
  @invoice = FactoryGirl.create :invoice, hash
end

Then 'I should see the invoice number' do
  expect(page).to have_selector '.invoice-number', text: (@invoice || Invoice.last).id # TODO: we really shouldn't use the ID as the invoice number
end