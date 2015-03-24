class AddUserVersionIdToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :user_version_id, :integer

    Invoice.all.each do |invoice|
      invoice.capture_association_versions!
      invoice.save!
    end

    change_column :invoices, :user_version_id, :integer, null: false

    add_foreign_key :invoices, :versions, column: :user_version_id
  end
end
