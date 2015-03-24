class AddClientAndProjectVersionIdsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :client_version_id, :integer
    add_column :invoices, :project_version_id, :integer

    Invoice.all.each do |invoice|
      invoice.capture_association_versions!
      invoice.save!
    end

    change_column :invoices, :client_version_id, :integer, null: false
    change_column :invoices, :project_version_id, :integer, null: false

    add_foreign_key :invoices, :versions, column: :client_version_id
    add_foreign_key :invoices, :versions, column: :project_version_id
  end
end
