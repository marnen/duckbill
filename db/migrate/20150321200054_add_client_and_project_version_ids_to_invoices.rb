class AddClientAndProjectVersionIdsToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :client_version_id, :integer, null: false
    add_column :invoices, :project_version_id, :integer, null: false

    add_foreign_key :invoices, :versions, column: :client_version_id
    add_foreign_key :invoices, :versions, column: :project_version_id
  end
end
